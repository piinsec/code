# selenium 4
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager
import time

driver = webdriver.Firefox(
    service=FirefoxService(GeckoDriverManager().install()))
# Path ကို raw string အဖြစ်ပြောင်းပါ
# path = r"C:\driver\geckodriver.exe"

# Firefox options များထည့်ခြင်း
# options = webdriver.FirefoxOptions()
# Firefox တပ်ဆင်ထားသော path
# options.binary_location = r"C:\Program Files\Mozilla Firefox\firefox.exe"

# driver = webdriver.Firefox(executable_path=path, options=options)

driver.get("https://github.com/usernam121")
repo = "https://github.com/usernam121"
# time.sleep(2)
res = driver.find_elements(By.CLASS_NAME, "repo")
# time.sleep(2)

links = []
flink = []
for i in res:
    links.append(i.text)

for l in links:
    next_page = f"{repo}/{l}"
    flink.append(next_page)

time.sleep(2)
driver.quit()


# try:
#     res = driver.find_elements(By.CLASS_NAME, "repo")
#     links = [i.text for i in res]
#     flink = [f"{repo}/{l}" for l in links]
#     print(flink)
# finally:
#     driver.quit()
