from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from openpyxl import load_workbook
import time

# Load Excel file
wb = load_workbook("your_file.xlsx")  # Replace with your filename
ws = wb.active  # Or specify: wb["Sheet1"]

# Set up Selenium Chrome driver
driver = webdriver.Chrome()
driver.get("https://your-target-website.com")  # Replace with actual URL

row = 2
while True:
    input_value = ws[f"A{row}"].value
    if not input_value:
        break

    try:
        # Clear and input data into field
        input_box = driver.find_element(By.NAME, "cwrelid")
        input_box.clear()
        input_box.send_keys(str(input_value))

        # Click the button
        button = driver.find_element(By.NAME, "but_rltnshop")
        button.click()

        time.sleep(2)  # Wait for results to load; adjust as needed

        # Extract result
        try:
            result = driver.find_element(By.CSS_SELECTOR, "td.bodytextnormal").text
        except:
            result = "Not found"

        ws[f"B{row}"] = result
        print(f"Row {row}: {input_value} -> {result}")

    except Exception as e:
        print(f"Error on row {row}: {e}")
        ws[f"B{row}"] = "Error"

    row += 1

# Save updated Excel file
wb.save("output_results.xlsx")
driver.quit()
print("Finished!")
