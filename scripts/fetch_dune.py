import requests
import csv
import json
import os

url = "https://api.dune.com/api/v1/query/4547514/results"

headers = {"X-DUNE-API-KEY": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"}
def fetch_dune_data(url, api_key, output_file_name):
    headers = {"X-DUNE-API-KEY": api_key}
    params = {"limit": 1000000, "offset": 0}  # Define limit and offset parameters

    response = requests.request("GET", url, headers=headers, params=params)
    data = response.json()

    # Extract rows and column names
    rows = data["result"]["rows"]
    column_names = data["result"]["metadata"]["column_names"]
    try:
        rows = data["result"]["rows"]
    except KeyError as e:
        with open("/Users/thleo/downloads/error_log.txt", mode='a') as log_file:
            log_file.write(f"Error fetching rows: {str(e)}\n")
        print(f"Error fetching rows: {str(e)}")
        return

    try:
        column_names = data["result"]["metadata"]["column_names"]
    except KeyError as e:
        with open("/Users/thleo/downloads/error_log.txt", mode='a') as log_file:
            log_file.write(f"Error fetching column names: {str(e)}\n")
        print(f"Error fetching column names: {str(e)}")
        return

    # Write to CSV
    csv_file_path = f"/Users/thleo/downloads/{output_file_name}.csv"
    file_exists = os.path.isfile(csv_file_path)
    with open(csv_file_path, mode='a', newline='') as file:
        print("Attempting to write to file...")
        writer = csv.DictWriter(file, fieldnames=column_names)
        if not file_exists:
            print("Creating file...")
            writer.writeheader()
        writer.writerows(rows)
    print(f'Downloaded and saved file {output_file_name}')

    # Print next URI and next offset
    print("Next URI:", data["next_uri"])
    print("Next Offset:", data["next_offset"])
    return data
    

# Example usage
data = fetch_dune_data("https://api.dune.com/api/v1/query/QQQQQQQ/results", "nQeBBjf8rVf2Lb68gmbDhwUMqZ7BhDqL", "dune_results__all")

print("initial fetch success")

# Print next URI and next offset
# print("Next URI:", data["next_uri"])
loop_count = 0
while data["next_uri"] and loop_count < 999999:
    loop_count+=1
    print(f"Now running looop {loop_count}")
    next_url = data["next_uri"]
    data = fetch_dune_data(next_url, headers["X-DUNE-API-KEY"], "dune_results__all")

    # Print next URI and next offset
    print("Next URI:", data["next_uri"])
    print("Next Offset:", data["next_offset"])

# print(response.text)