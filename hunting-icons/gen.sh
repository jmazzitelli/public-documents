#!/usr/bin/env bash

BASE_RAW="https://raw.githubusercontent.com/jmazzitelli/public-documents/main/hunting-icons"
LOCAL_DIR="."   # Path to the local clone
OUTPUT="index.html"

cat > "$OUTPUT" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Icon Index</title>
<style>
body { font-family: Arial, sans-serif; margin: 20px; }
h2 { margin-top: 40px; border-bottom: 2px solid #ccc; padding-bottom: 5px; }
.icon-grid { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 10px; }
.icon-item { text-align: center; font-size: 12px; width: 100px; }
.icon-item img { max-width: 64px; max-height: 64px; display: block; margin: 0 auto 5px; }
</style>
</head>
<body>
<h1>Icon Index</h1>
EOF

# Walk all directories recursively
find "$LOCAL_DIR" -type d | while read -r dir; do
    # List PNG files in this directory
    files=$(find "$dir" -maxdepth 1 -type f -name "*.png" | sort)
    if [ -n "$files" ]; then
        category=${dir#./}
        echo "<h2>$category</h2>" >> "$OUTPUT"
        echo "<div class=\"icon-grid\">" >> "$OUTPUT"
        for f in $files; do
            # Remove leading ./ for raw URL
            relative=${f#./}
            echo "<div class=\"icon-item\"><img src=\"$BASE_RAW/${relative#black/}\" alt=\"$f\"><br>$(basename "$f")</div>" >> "$OUTPUT"
        done
        echo "</div>" >> "$OUTPUT"
    fi
done

cat >> "$OUTPUT" <<EOF
</body>
</html>
EOF

echo "Generated $OUTPUT"

