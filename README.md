# Geospatial Data Pipeline with Neo4j and Semantic Embeddings

This repository provides an end-to-end pipeline to import, embed, and semantically query geospatial datasets using Neo4j and Python. It integrates several datasets, including **GridKit**, **CORDIS**, **EU Power Plants**, **ENTSO-E TSO Network**, and **OpenStreetMap (OSM)** energy infrastructure.

## 📚 Included Datasets

- **GridKit European Transmission Grid**
- **CORDIS EU Projects**
- **EU Power Plants**
- **ENTSO-E TSO Network**
- **OpenStreetMap (OSM) Energy Infrastructure**
  - Charging Stations
  - Power Plants
  - Solar Farms
  - Wind Turbines
  - Substations
  - Transmission Lines

## 🛠️ Technologies Used

- **Neo4j 5.19.0** (Graph Database)
- **Docker & Docker Compose** (Containerization)
- **Python 3.11**
- **LangChain & SentenceTransformer** (Semantic Embeddings)

## 📂 Project Structure

Ensure your directory structure matches explicitly:

```plaintext
project_root/
├── data/                        # CSV files for Neo4j import
├── scripts/
│   ├── import/                  # Cypher import scripts
│   └── embeddings/              # Python embedding scripts
├── docker-compose.yaml          # Docker Compose file
├── Dockerfile                   # Dockerfile for embedding worker
├── requirements.txt             # Python dependencies
├── entrypoint.sh                # Entrypoint script
└── .env                         # Environment variables
```

# 📖 Installation Steps 

## Step 1: Clone the Repository

Clone your repository explicitly into your VM:

```bash
git clone <your_repository_url>
cd <your_repository_folder>
```

## Step 2: Configure Environment Variables

Create a `.env` file explicitly at the root directory:

```bash
NEO4J_USER=neo4j
NEO4J_PASSWORD=your_secure_password
NEO4J_URL=bolt://neo4j:7687
EMBEDDING_MODEL_NAME=all-MiniLM-L6-v2
```

## Step 3: Populate CSV Data

Place all CSV files explicitly into the `data/` directory.

## Step 4: Start Containers

```bash
docker-compose build
docker-compose up -d
```

# 📝 Data Import and Embedding Workflow

The containers explicitly perform the following workflow:

- Wait for Neo4j to be ready
- Check explicitly if Neo4j database is empty
- Explicitly import datasets (GridKit, CORDIS, EU Power Plants, ENTSO-E TSO Networks, OSM)
- Generate semantic embeddings explicitly

## Manual Execution (if needed)

You can manually execute imports or embeddings explicitly inside the embeddings_worker container:

```bash
docker exec -it embeddings_worker bash
```

Then run individual scripts explicitly:

```bash
python scripts/embeddings/gridkit_embeddings.py
```

# 📄 File Summary

- `docker-compose.yaml`: Container orchestration explicitly defined.
- `Dockerfile`: Python embedding worker explicitly defined.
- `entrypoint.sh`: Explicitly orchestrates imports and embeddings.
- `.env`: Environment variables explicitly defined.
- `requirements.txt`: Explicit Python dependencies.
- `scripts/import/*.cypher`: Explicit data import Cypher scripts.
- `scripts/embeddings/*.py`: Embedding generation and querying scripts.
- `data/`: CSV datasets explicitly for Neo4j import.