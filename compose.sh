#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage: $0 file1 file2 ... -o output_file"
    exit 1
fi

output_file=""
files=()
parsing_files=true

for arg in "$@"; do
    if [ "$arg" = "-o" ]; then
        parsing_files=false
        continue
    fi

    if $parsing_files; then
        files+=("$arg")
    else
        output_file="$arg"
    fi
done

if [ -z "$output_file" ]; then
    echo "error: specify output file using -o"
    exit 1
fi

> "$output_file"

index=0
for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "warning: file $file not found, skip"
        continue
    fi

    filename=$(basename "$file")

    content=$(cat "$file")

    {
        echo "$((index + 1)). $filename"
        echo "\`\`\`verilog"
        echo "$content"
        echo "\`\`\`"
        echo ""  
    } >> "$output_file"

    ((index++))
done

echo "files written in $output_file"
