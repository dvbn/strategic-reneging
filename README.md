# Strategic Reneging and Market Power in Sequential Markets

David Benatia and Étienne Billette de Villemeur. *RAND Journal of Economics*
56(1), 2025, pp. 3–34.

[Published paper](https://doi.org/10.1111/1756-2171.12488) · [Author website and materials](https://davidbenatia.com/research/)

MATLAB replication code for the Alberta electricity-market application.

## Usage

1. Download the accompanying data ZIP from the paper materials on the author website.
2. Extract it into this repository, creating `Data/` with the three `.mat` files.
3. Install glmnet for MATLAB and add it to the MATLAB path. The analysis also uses
   MATLAB statistics functions.
4. Run `main.m` from MATLAB.

The runner creates `Figures/`, `Tables/` and `Tempfiles/`. The bootstrap uses 5,000
draws and can take substantial time. Dataset variables and sources are described
in `README_datasets.txt` (AESO and Environment Canada).
