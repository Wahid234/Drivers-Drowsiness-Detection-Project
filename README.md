# Driver Drowsiness Detection System

A real-time driver drowsiness detection system using eye state analysis. Captures driver images via mobile camera and uses machine learning to detect signs of drowsiness.

## Table of Contents
- [Project Overview](#project-overview)
- [System Architecture](#System-Architecture)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Alert Notification](#alert-system)
- [Contributing](#contributing)
- [Contact](#contact)
- [Demo](#Demo)

## Project Overview
This system consists of two main components:
1. **Mobile Application**: Captures driver images (2 images/minute) and communicates with API
2. **Detection Model**: Uses Haar cascade classifier for face detection and pre-trained CNN for eye state classification

Workflow:
1. Mobile app captures and sends images to API
2. Server processes images using OpenCV and ML model
3. Returns eye state classification with confidence score
4. Triggers alerts when eyes are closed beyond threshold


## System Architecture
![System Architecture](./System%20Architecture.png)

## Features
- Real-time image capture and processing
- Haar cascade face detection
- Eye state classification (Open/Closed)
- Confidence percentage for predictions
- REST API integration
- Customizable alert thresholds
- Multi-platform support

## Installation
### Prerequisites
- Python 3.10+
- OpenCV
- TensorFlow/Keras (for model loading)
- Flask (for API server)
- Android/iOS development environment (for mobile app)

### Setup
1. Clone repository:
```bash
git clone https://github.com/Wahid234/driver-drowsiness-detection.git
cd driver-drowsiness-detection
```
2. Install Python dependencies:

```bash
pip install -r requirements.txt
```


## Usage
### Mobile Application
1. Place phone in vehicle facing driver
2. Launch application
3. Grant camera permissions
4. System will auto-capture images and send to API

### Backend Server
1. Detection Model
2. API Integration


## Customizable alert Notification types:

1. 🔊 Audio alarm 
2. 📳 Vibration


## 🤝 Contributors
- [Wahid Alzubeir](https://github.com/Wahid234) (Detection Model and API)
- [Essa Shehab](https://github.com/EssaCoder/EssaCoder) (Flutter)


## Contact
For questions or support, contact:
Wahid Alzubeir - wahid.alzubeir1@gmail.com

Project Link: https://github.com/Wahid234/driver-drowsiness-detection

## Demo
![Start track](./image/Start%20track%20page.png)
![Alert notification](./image/Alert%20notification.png)
![Alert notification2](./image/Alert%20notification%202.png)


