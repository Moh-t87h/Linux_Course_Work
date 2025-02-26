#!/bin/bash

CSV_FILE="species_data.csv"
OUTPUT_LOG="5_output.txt"

# פונקציה להדפסת הודעות ושמירתן בקובץ
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$OUTPUT_LOG"
}

# בדיקה אם קובץ ה-CSV קיים, אחרת ליצור אותו
if [[ ! -f "$CSV_FILE" ]]; then
    echo "Date collected,Species,Sex,Weight" > "$CSV_FILE"
    echo "1/8,PF,M,7" >> "$CSV_FILE"
    echo "2/18,OT,M,24" >> "$CSV_FILE"
    echo "2/19,OT,F,23" >> "$CSV_FILE"
    echo "3/11,NA,M,232" >> "$CSV_FILE"
    echo "3/11,OT,F,22" >> "$CSV_FILE"
    echo "3/11,OT,M,26" >> "$CSV_FILE"
    echo "3/11,PF,M,8" >> "$CSV_FILE"
    echo "4/8,NA,F,8" >> "$CSV_FILE"
    echo "5/6,NA,F,45" >> "$CSV_FILE"
    echo "5/18,NA,F,182" >> "$CSV_FILE"
    echo "6/9,OT,F,29" >> "$CSV_FILE"
    log_message "CSV file created with initial data."
fi

# פונקציה להצגת התפריט
display_menu() {
    echo "======================================"
    echo "        CSV Data Management          "
    echo "======================================"
    echo "1. Display all CSV data with index"
    echo "2. Add a new row"
    echo "3. Read species data and calculate avg weight"
    echo "4. Read species by sex"
    echo "5. Save output to new CSV file"
    echo "6. Delete row by index"
    echo "7. Update weight by index"
    echo "8. Exit"
    echo "--------------------------------------"
    echo "Enter your choice (or type 'Exit' to quit):"
}

# פונקציה להצגת הנתונים עם אינדקס
display_csv() {
    log_message "Displaying CSV data:"
    nl -w2 -s' ' "$CSV_FILE" | tee -a "$OUTPUT_LOG"
}

# פונקציה להוספת שורה חדשה
add_new_row() {
    echo "Enter Date collected (e.g., 7/10):"
    read date_collected
    echo "Enter Species (e.g., OT, PF, NA):"
    read species
    echo "Enter Sex (M/F):"
    read sex
    echo "Enter Weight:"
    read weight

    echo "$date_collected,$species,$sex,$weight" >> "$CSV_FILE"
    log_message "New row added: $date_collected, $species, $sex, $weight"
}

# פונקציה להצגת מין ספציפי עם חישוב משקל ממוצע
display_species_avg_weight() {
    echo "Enter species to filter (e.g., OT):"
    read species
    awk -F, -v sp="$species" '$2 == sp {sum+=$4; count++; print $0} END {if (count>0) print "Average weight:", sum/count}' "$CSV_FILE" | tee -a "$OUTPUT_LOG"
}

# פונקציה להצגת נתונים לפי מין (M/F)
display_sex() {
    echo "Enter sex (M/F) to filter:"
    read sex
    awk -F, -v sx="$sex" '$3 == sx {print $0}' "$CSV_FILE" | tee -a "$OUTPUT_LOG"
}

# פונקציה לשמירת הפלט לקובץ חדש
save_to_new_csv() {
    cp "$CSV_FILE" "species_data_backup.csv"
    log_message "Saved output to a new CSV file (species_data_backup.csv)"
}

# פונקציה למחיקת שורה לפי אינדקס
delete_row_by_index() {
    echo "Enter row index to delete:"
    read index
    sed -i "${index}d" "$CSV_FILE"
    log_message "Deleted row $index from CSV."
}

# פונקציה לעדכון משקל לפי אינדקס
update_weight_by_index() {
    echo "Enter row index to update weight:"
    read index
    echo "Enter new weight:"
    read new_weight
    awk -v idx=$index -v new_weight="$new_weight" 'NR==idx { $4=new_weight } 1' FS=, OFS=, "$CSV_FILE" > temp.csv && mv temp.csv "$CSV_FILE"
    log_message "Updated weight at row $index to $new_weight."
}

# לולאה ראשית שמריצה את התפריט
# לולאה ראשית שמריצה את התפריט
while true; do
    display_menu
    echo "Choose an option (or type 'Exit' to quit):"
    read choice

    case $choice in
        1) display_csv ;;
        2) add_new_row ;;
        3) display_species_avg_weight ;;
        4) display_sex ;;
        5) save_to_new_csv ;;
        6) delete_row_by_index ;;
        7) update_weight_by_index ;;
        8) log_message "Exiting program."; exit 0 ;;
        9) log_message "Invalid option: $choice. Please choose a valid number."; echo "Invalid option, try again." ;;
        [Ee][Xx][Ii][Tt]) log_message "User requested exit. Exiting program."; exit 0 ;;
        *) log_message "Invalid option: $choice. Please choose a valid number."; echo "Invalid option, try again." ;;
    esac
done
