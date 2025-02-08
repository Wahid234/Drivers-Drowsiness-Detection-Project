from rest_framework import generics
import h5py
import cv2
import os
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from .serializers import PredictSerializer,PredictEditSerializer
from .models import Predict
from keras.models import load_model

class PredictListView(generics.ListAPIView):
    queryset = Predict.objects.all()
    serializer_class = PredictSerializer
    
class PredictListCreateView(generics.ListCreateAPIView):
    serializer_class = PredictEditSerializer
    
    def get_queryset(self):
        # Custom queryset logic
        return None
    
    def create(self, request, *args, **kwargs):
        # Custom create logic here
        message="There is no image"
        status = 0
        if request.FILES:
            image_file = request.FILES.get('image')
            predict=Predict()
            predict.origin_image=image_file
            image_filename = image_file.name
            image_path = os.path.join('static/predicts/', image_filename)
            image_full_path = os.path.join('static/predicts/', image_filename)
            with open(image_path, 'wb') as f:
                f.write(image_file.read())

            image = cv2.imread(image_path)
            predict.image=image_full_path
            imagepath = []
            faceCascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
            eyeCascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')
            gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
            faces = faceCascade.detectMultiScale(gray, 1.3, 5)
            face_detected = False
            eye_detected = False
            status = 1
            if len(faces) == 0:
                message="No face detected"
            else:
                face_detected = True
                message="Face detected"
                for (x, y, w, h) in faces:
                    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0), 2)
                    roi_gray = gray[y:y + h, x:x + w]
                    roi_color = image[y:y + h, x:x + w]
                    faces_roi = image[y:y + h, x:x + w]

                    if len(faces_roi) == 0:
                        message="No face found"
                    else:
                        color_img = cv2.cvtColor(faces_roi, cv2.COLOR_BGR2RGB)
                        eyes = eyeCascade.detectMultiScale(color_img, 1.1, 4)

                        for (ex, ey, ew, eh) in eyes:
                            cv2.rectangle(color_img, (ex, ey), (ex + ew, ey + eh), (0, 255, 0), 1)

                        eyes = eyeCascade.detectMultiScale(color_img, 1.1, 4)
                        count = 0

                        for ex, ey, ew, eh in eyes:
                            count += 1
                            roi_gray = color_img[ey:ey + eh, ex:ex + ew]
                            roi_color = color_img[ey:ey + eh, ex:ex + ew]
                            eyess = eyeCascade.detectMultiScale(roi_gray)
                            
                            status = 2
                            if len(eyess) == 0:
                                message="Drowsiness detected in the two eyes"
                            else:
                                eye_detected = True
                                if count == 1:
                                    message="Drowsiness detected in the one eyes"
                                else:
                                    message="No drowsiness was detected"
                                drowsiness_results = []
                                for ex, ey, ew, eh in eyess:
                                    eyes_roi = roi_color[ey:ey + eh, ex:ex + ew]

                                    if len(eyes_roi) != 0:
                                        best_model = load_model('bestModel.h5')
                                        image = cv2.resize(eyes_roi, (64, 64))
                                        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
                                        image = np.expand_dims(image, axis=0)
                                        image = np.expand_dims(image, axis=-1)
                                        image = image / 255.0  # Normalize the pixel values between 0 and 1
                                        result = best_model.predict(image)
                                        drowsiness_results.append(result)

                                        e_image = cv2.cvtColor(eyes_roi, cv2.COLOR_BGR2RGB)
                                        e_image = cv2.resize(eyes_roi, (224, 224))
                                        cv2.imwrite(image_full_path, e_image)
                                        status = 3
                                    else:
                                        message="Eyes not detected"
                            if status == 3 and any(result > 0.35 for result in drowsiness_results):
                                if count == 1:
                                    message += ' (One eye is Open)'
                                else:
                                    message += ' (Two eyes are Open)'
                            else:
                                message+= ' (Two eyes are Closed)'
            if(status != 1):
                predict.messages=message
                predict.save()
        return Response({"Message": message, "Status": status})

class PredictUpdateView(generics.RetrieveUpdateAPIView):
    queryset = Predict.objects.all()
    serializer_class = PredictSerializer
    
    def perform_update(self, instance):
        # custom update logic here
        return super().perform_update(instance)

class PredictDeleteView(generics.RetrieveDestroyAPIView):
    queryset = Predict.objects.all()
    serializer_class = PredictSerializer
    
    def perform_destroy(self, instance):
        instance.delete()