# Function to check if a package is installed, load it, and print the version
load_package <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    if (pkg == "TCGAbiolinks") {
      # Install BiocManager if not already installed
      if (!requireNamespace("BiocManager", quietly = TRUE)) {
        install.packages("BiocManager")
      }
      BiocManager::install(pkg, dependencies = TRUE)  # Install Bioconductor package
    } else {
      install.packages(pkg, dependencies = TRUE)  # Install CRAN package
    }
  }
  library(pkg, character.only = TRUE)  # Load the package
  version <- packageVersion(pkg)  # Get the package version
  cat(paste(pkg, "version:", as.character(version), "\n"))  # Print the version
}

# Print R version
cat("R version:", R.version.string, "\n")

# Load BiocManager and print its version
load_package("BiocManager")
bioc_version <- packageVersion("BiocManager")
cat("BiocManager version:", as.character(bioc_version), "\n")

# Load necessary libraries with checks
load_package("TCGAbiolinks")  # For downloading TCGA data
load_package("GEOquery")      # For downloading GEO datasets
load_package("sva")           # For batch effect removal

# Define the output directories
raw_data_dir <- "data/raw"
processed_data_dir <- "data/processed"

# Create output directories if they don't exist
dir.create(raw_data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(processed_data_dir, recursive = TRUE, showWarnings = FALSE)

# TCGA-CESC data collection and transformation
query <- GDCquery(project = "TCGA-CESC", 
                  data.category = "Transcriptome Profiling", 
                  data.type = "Gene Expression Quantification", 
                  workflow.type = "HTSeq - TPM")

# Download the data
GDCdownload(query)
tcga_data <- GDCprepare(query)

# Transform to log2(TPM + 1)
tcga_data_tpm <- log2(tcga_data + 1)

# Save the raw TCGA data
saveRDS(tcga_data_tpm, file = file.path(raw_data_dir, "tcga_cesc_data.rds"))

# GEO datasets loading
gse44001 <- getGEO("GSE44001", GSEMatrix = TRUE)
gse52903 <- getGEO("GSE52903", GSEMatrix = TRUE)

# Extracting the expression data
gse44001_expr <- exprs(gse44001[[1]])
gse52903_expr <- exprs(gse52903[[1]])

# Save raw GEO data
saveRDS(gse44001_expr, file = file.path(raw_data_dir, "gse44001_data.rds"))
saveRDS(gse52903_expr, file = file.path(raw_data_dir, "gse52903_data.rds"))

# Preprocessing: Remove samples with missing clinical or expression data
tcga_data_filtered <- tcga_data_tpm[complete.cases(tcga_data_tpm), ]
gse44001_filtered <- gse44001_expr[complete.cases(gse44001_expr), ]
gse52903_filtered <- gse52903_expr[complete.cases(gse52903_expr), ]

# Combine the filtered data for batch effect removal
combined_data <- cbind(tcga_data_filtered, gse44001_filtered, gse52903_filtered)

# Batch effect removal using ComBat
batch <- c(rep("TCGA", ncol(tcga_data_filtered)), 
           rep("GSE44001", ncol(gse44001_filtered)), 
           rep("GSE52903", ncol(gse52903_filtered)))

combat_data <- ComBat(dat = combined_data, batch = batch)

# Save the processed data
saveRDS(combat_data, file = file.path(processed_data_dir, "combat_data.rds"))

# Print success message
cat("Data collection and preprocessing completed successfully!\n")
