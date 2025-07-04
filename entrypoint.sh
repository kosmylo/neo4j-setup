#!/bin/bash

source .env

# Wait explicitly for Neo4j to be fully ready
echo "Waiting explicitly for Neo4j to start..."
until curl -sSf http://neo4j:7474 >/dev/null; do
  sleep 3
done
echo "Neo4j is ready."

# Check explicitly if Neo4j is empty
NODE_COUNT=$(cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" \
  -a neo4j://neo4j:7687 "MATCH (n) RETURN count(n);" --format plain | tail -1 | awk '{print $1}')

if [ "$NODE_COUNT" -eq 0 ]; then
    echo "Neo4j database is empty. Explicitly starting import and embeddings generation."

    # GridKit Data
    cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" < scripts/import/gridkit_import.cypher
    python scripts/embeddings/gridkit_embeddings.py

    # CORDIS Data
    cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" < scripts/import/cordis_import.cypher
    python scripts/embeddings/cordis_embeddings.py

    # EU Power Plants Data
    cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" < scripts/import/powerplants_import.cypher
    python scripts/embeddings/powerplants_embeddings.py

    # ENTSO-E TSO Network Data
    cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" < scripts/import/tso_network_import.cypher
    python scripts/embeddings/tso_network_embeddings.py

    # OSM Data
    cypher-shell -u "$NEO4J_USER" -p "$NEO4J_PASSWORD" < scripts/import/osm_import.cypher
    python scripts/embeddings/osm_embeddings.py

    echo "All datasets explicitly imported and embeddings generated successfully."
else
    echo "Neo4j database already contains data (Node count: $NODE_COUNT). Skipping imports and embeddings."
fi

echo "Initialization complete. Keeping container alive."
tail -f /dev/null  # Explicitly keeps container alive