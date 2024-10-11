# Reproduce-HMAG-Signature-Cervical-Cancer

This repository contains R scripts and workflows to reproduce the bioinformatics analysis performed in the study:  
**"Assessment of alterations in histone modification function and guidance for death risk prediction in cervical cancer patients"** by Zhao et al. (2022).

### **Study Information**
- **Authors**: Zhao, T., Liu, B., Zhang, M., Li, S., Zhao, C., & Cheng, L.
- **Published in**: Frontiers in Genetics, 2022.
- **DOI**: [https://doi.org/10.3389/fgene.2022.1013571](https://doi.org/10.3389/fgene.2022.1013571)
- **PMID**: [36199574](https://pubmed.ncbi.nlm.nih.gov/36199574/)
- **PMCID**: [PMC9527294](https://doi.org/10.3389/fgene.2022.1013571)

### **Abstract**  
Cervical cancer is the second most lethal malignancy among women, and this study evaluated the prognostic value of histone modification in cervical cancer patients. Using data from TCGA-CESC, GSE44001, and GSE52903, along with 122 histone modification-associated pathways, a nine-gene **Histone Modification-Associated Gene (HMAG)** signature was developed. The analysis involved GSVA, LASSO regression, and pathway enrichment using `clusterProfiler` and other R packages. The HMAG signature demonstrated strong prognostic value and was associated with differential drug responses. 

### **Objective of the Repository**  
This repository aims to reproduce the results and analysis of the study using the publicly available datasets and bioinformatics pipelines described. The analysis includes:

- Data preprocessing and batch effect removal.
- Gene Set Variation Analysis (GSVA).
- Differentially expressed genes (DEGs) and pathway enrichment analysis.
- Construction of the HMAG signature using LASSO regression.
- Prediction of therapeutic drugs.

### **Datasets**  
The analysis makes use of publicly available datasets:
- **TCGA-CESC**: Transcriptome data from The Cancer Genome Atlas.
- **GSE44001** and **GSE52903**: Gene expression data from GEO.

### **R Packages Required**  
- **TCGAbiolinks**
- **GEOquery**
- **sva**
- **GSVA**
- **limma**
- **clusterProfiler**
- **glmnet**
- **regplot**
- **MOVICS**

### **Reproducibility**  
This project adheres to open science principles, and all analyses can be reproduced by following the provided R scripts and the workflow documented in the configuration files. The workflow is encapsulated in a YAML configuration file, ensuring that inputs and outputs are well-documented for reproducibility.

### **How to Run the Code**  
1. Clone this repository:
   ```bash
   git clone https://github.com/biocodebreaker/Reproduce-HMAG-Signature-Cervical-Cancer.git

2. Set up the R environment and install required packages:
   install.packages(c("TCGAbiolinks", "GEOquery", "sva", "GSVA", "limma", "clusterProfiler", "glmnet", "regplot", "MOVICS"))
3. Follow the scripts provided in the src/ directory to replicate the study analysis.
4. Results including Tables and Figures will be generated in the output/ directory.

### Citations

Please cite the original study if you use this repository or code in your research:

Zhao, T., Liu, B., Zhang, M., Li, S., Zhao, C., & Cheng, L. (2022). Assessment of alterations in histone modification function and guidance for death risk prediction in cervical cancer patients. Frontiers in Genetics, 13, 1013571. DOI: https://doi.org/10.3389/fgene.2022.1013571
