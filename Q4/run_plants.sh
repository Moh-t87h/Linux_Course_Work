#!/usr/bin/env bash
# run_plants.sh - Script to run plant_plots.py for each line in a CSV file,
# Create separate folders for each plant and save logs.
#
# Usage: ./run_plants.sh <path-to-csv>
# For example: ./run_plants.sh plants_data.csv

# Set variables
CSV_FILE="$1"
PYTHON_SCRIPT="plant_plots.py"
LOG_FILE="run_plants.log"
ERROR_LOG="run_plants_errors.log"
VENV_DIR="../venv"
PLANTS_DIR="Plants" # Name of the main folder to save plant data

# Function to print messages to the log
log_message() {
echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to print errors to the error log
log_error() {
echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" | tee -a "$ERROR_LOG"
}

# Check if CSV file provided
if [[ -z "$CSV_FILE" ]]; then
log_error "No CSV file provided! Usage: ./run_plants.sh <path-to-csv>"
exit 1
fi

# Check if CSV file exists
if [[ ! -f "$CSV_FILE" ]]; then
log_error "CSV file '$CSV_FILE' not found!"
exit 1
fi

log_message "Starting the process of creating diagrams for all plants from the file $CSV_FILE..."

# Creating a main Plants folder if it does not exist
mkdir -p "$PLANTS_DIR"

# Creating a virtual environment if it does not exist
if [[ ! -d "$VENV_DIR" ]]; then
log_message "Creating a virtual environment..."
python3 -m venv "$VENV_DIR"
else
log_message "A virtual environment already exists."
fi

# Activating the virtual environment
source "$VENV_DIR/bin/activate"
log_message "The virtual environment has been activated."

# Installing matplotlib inside the environment
log_message "Installing required packages..."
pip install --quiet matplotlib 2>>"$ERROR_LOG" || log_error "Failed to install packages."

# Read the CSV file (skip the first line with the headers)
tail -n +2 "$CSV_FILE" | while IFS=',' read -r PLANT HEIGHT LEAF_COUNT DRY_WEIGHT; do
    # הסרת מרכאות מהנתונים
    HEIGHT=$(echo $HEIGHT | tr -d '"')
    LEAF_COUNT=$(echo $LEAF_COUNT | tr -d '"')
    DRY_WEIGHT=$(echo $DRY_WEIGHT | tr -d '"')

    log_message "Processing plant: $PLANT"

    # המשך הסקריפט...

log_message "Processing data for plant: $PLANT"

# Create a folder for the plant in Plants
PLANT_DIR="${PLANTS_DIR}/${PLANT}"
mkdir -p "$PLANT_DIR"
log_message "Created folder: $PLANT_DIR"

# Run the Python code with the parameters from the CSV
python3 "$PYTHON_SCRIPT" --plant "$PLANT" --height $HEIGHT --leaf_count $LEAF_COUNT --dry_weight $DRY_WEIGHT \
>>"$LOG_FILE" 2>>"$ERROR_LOG" || log_error "Failed to run Python for $PLANT"

# Moving generated images to the plant directory
mv *.png "$PLANT_DIR" 2>/dev/null
log_message "Images for $PLANT have been moved to directory: $PLANT_DIR"
done

# Exiting the virtual environment
deactivate
log_message "The virtual environment has been closed."

log_message "The diagram creation process has completed successfully!"

exit 0