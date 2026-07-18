from pathlib import Path
import csv


project_root = Path(__file__).resolve().parent.parent

input_file = (
    project_root
    / "data"
    / "raw"
    / "archive"
    / "olist_order_reviews_dataset.csv"
)

output_directory = project_root / "data" / "interim"

output_file = (
    output_directory
    / "olist_order_reviews_cleaned.csv"
)

output_directory.mkdir(parents=True, exist_ok=True)


with input_file.open(
    mode="r",
    encoding="utf-8",
    newline=""
) as source_file:

    reader = csv.reader(source_file)

    with output_file.open(
        mode="w",
        encoding="utf-8",
        newline=""
    ) as destination_file:

        writer = csv.writer(
            destination_file,
            quoting=csv.QUOTE_MINIMAL,
            lineterminator="\n"
        )

        row_count = 0

        for row in reader:

            cleaned_row = [
                value.replace("\r", " ").replace("\n", " ").strip()
                for value in row
            ]

            writer.writerow(cleaned_row)

            row_count += 1


print("Review file cleaned successfully.")
print(f"Output file: {output_file}")
print(f"Total rows including header: {row_count}")
print(f"Data rows: {row_count - 1}")