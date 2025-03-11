import runpod
from main import prompt
import requests
        

def handler(event):
    input = event['input']
    workflow = input.get('workflow')
    webhook_url = input.get('webhook_url')

    # Placeholder for a task; replace with image or text generation logic as needed
    result = prompt(workflow)
    result = result.json()
    print(result)

    # Send result to webhook
    if webhook_url:
        requests.post(webhook_url, json=result)

    return result

if __name__ == '__main__':
    runpod.serverless.start({'handler': handler})