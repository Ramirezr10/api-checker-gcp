import time
import request
from google.cloud import logging


def monitor_site(url):
	logging_client = logging.Client()
	logger = logging_client.logger("health-checker-logs")

	while True:
		try:
			response = request.get(url)
			status = f"Site {url} is UP. Status: {reponse.status_code}"
			print(status)
			logger.log_text(status, severity="INFO")

		except Exception as e:
			status = f"Site {url} is DOWN! Error: {e}"
			print(status)
			logger.log_text(status, severity="ERROR")


		time.sleep(60) #Check every minute

if __name__ == "__main__":
	monitor_site(https://google.com)