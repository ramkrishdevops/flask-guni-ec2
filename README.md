
                   ┌────────────────────────┐
                   │        Developer       │
                   │    Push to GitHub      │
                   └────────────┬───────────┘
                                │
                                ▼
                   ┌────────────────────────┐
                   │     GitHub Actions     │
                   │  CI/CD Pipeline Runs   │
                   └────────────┬───────────┘
                                │
                                ▼
        ┌────────────────────────────────────────────────────┐
        │       Deployment Path (You Choose One)             │
        │                                                    │
        │  1. SSH (current setup)                            │
        │        GitHub → SSH → EC2 → Pull code → Restart    │
        │                                                    │
        │  2. SSM (recommended, secure, no SSH keys)         │
        │        GitHub → AWS SSM → EC2 → Run Commands       │
        │                                                    │
        └──────────────────────┬─────────────────────────────┘
                               │
                               ▼
                   ┌────────────────────────┐
                   │          EC2           │
                   │   Flask + Gunicorn     │
                   │   systemd service       │
                   └────────────┬───────────┘
                                                               │
                                ▼
                   ┌────────────────────────┐
                   │        Microsoft       │
                   │          Teams         │
                   │ Deploy Success/Failure │
                   __________________________


# 🚀 Automated Deployment to AWS EC2 using GitHub Actions + Teams Notifications  
### Secure, Simple, Server-Friendly CI/CD (SSH or SSM Mode)

This repository demonstrates a clean and reliable CI/CD pipeline for deploying a Flask application to an **AWS EC2** instance using **GitHub Actions**, with **status notifications sent to Microsoft Teams**.

Supports:

- **SSH mode** (simple — your current setup)  
-- **SSM mode** (recommended — no SSH keys, fully AWS-native)  
- **Automatic Python venv management**  
- **systemd Gunicorn service**  
- **Teams notifications for success/failure**  

---

### 🔹 Option A: SSH Deployment (Default)
GitHub Actions uses SSH to:
- Pull latest code  
- Install Python dependencies  
- Restart systemd service 
---
## 🖥️ EC2 Setup

### Install Python & venv
```bash
sudo apt update
sudo apt install -y python3 python3-venv
--
python3 -m venv venv
--

systemd Gunicorn Service
Place this in: /etc/systemd/system/flaskapp.service


[Unit][
Description=Flask Gunicorn App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/flask-guni-ec2
Environment="PATH=/home/ubuntu/flask-guni-ec2/venv/bin:/usr/bin"
ExecStart=/home/ubuntu/flask-guni-ec2/venv/bin/gunicorn --bind 0.0.0.0:8000 wsgi:app
Restart=always

[Install]


------


sudo systemctl daemon-reload
sudo systemctl enable flaskapp
sudo systemctl start flaskapp

---


{
  "EC2_HOST": "EC2 Public IP or DNS",
  "EC2_USER": "ubuntu",
  "EC2_KEY": "SSH private key (PEM)",
  "TEAMS_WEBHOOK_URL": "Microsoft Teams Incoming Webhook URL"
}


---

🔔 Setting Up Teams Webhook

Open your Team → Channel
Click … More options → Connectors
Choose Incoming Webhook
Click Configure
Copy the webhook URL
Add it to GitHub Secrets as TEAMS_WEBHOOK_URL

----

✔ Deployment Test


git add .
git commit -m "Test deployment"
git push origin main

---


