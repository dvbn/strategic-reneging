# Strategic Reneging and Market Power in Sequential Markets

David Benatia and Étienne Billette de Villemeur. *RAND Journal of Economics*
56(1), 2025, pp. 3–34.

[Published paper](https://doi.org/10.1111/1756-2171.12488) · [Author manuscript](https://www.dropbox.com/scl/fi/0d24x61hxs1mp3xt73ocb/strategic-reneging-working-paper-2025-11.pdf?rlkey=685yxu5mq6a7vq6ljmddz39di&dl=0) · [Author website and materials](https://davidbenatia.com/research/)

MATLAB replication code for the Alberta electricity-market application.
Accompanying files are in the [Dropbox materials folder](https://www.dropbox.com/scl/fo/2g926w1121i6458fuobhh/ACg33KnxG1ZXQ87SrkajBAQ?rlkey=s2ukty5p05xqya00znqrxuj77&dl=0).

## Usage

1. Download the [data ZIP](https://www.dropbox.com/scl/fi/05ghsanlowuzzl6fudf9g/strategic-reneging-data.zip?rlkey=qjguecndarif2yfem1m2onioq&dl=0).
2. Extract it into this repository, creating `Data/` with the three `.mat` files.
3. Install glmnet for MATLAB and add it to the MATLAB path. The analysis also uses
   MATLAB statistics functions.
4. Run `main.m` from MATLAB.

The runner creates `Figures/`, `Tables/` and `Tempfiles/`. The bootstrap uses 5,000
draws and can take substantial time. Dataset variables and sources are described
in `README_datasets.txt` (AESO and Environment Canada).
