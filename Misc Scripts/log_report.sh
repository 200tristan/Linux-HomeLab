#!/bin/bash

# Function to extract major errors from log files
extract_errors() {
    log_file="$1"
    errors=$(grep -i "error" "$log_file" | grep -iv "warning")
    echo "$errors"
}

# Function to generate the report
generate_report() {
    folder="$1"
    report_file="$2"
    
    # Search for log files recursively and extract errors
    while IFS= read -r -d '' log_file; do
        echo "Scanning: $log_file"
        errors=$(extract_errors "$log_file")
        
        # Append errors to the report file
        if [ -n "$errors" ]; then
            echo "Log file: $log_file" >> "$report_file"
            echo "Errors:" >> "$report_file"
            echo "$errors" >> "$report_file"
            echo "-------------------" >> "$report_file"
        fi
    done < <(find "$folder" -type f -name "*.log" -print0)
}

# Entry point of the script
main() {
    folder="$1"
    report_file="$2"
    
    # Create a new report file or overwrite existing one
    > "$report_file"
    
    # Generate the report
    generate_report "$folder" "$report_file"
    
    echo "Report generated successfully. Please check $report_file"
}

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <folder> <report_file>"
    exit 1
fi

main "$1" "$2"
