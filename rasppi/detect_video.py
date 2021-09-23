import cv2
import time

gato = False

if (gato):
    face_cascade = cv2.CascadeClassifier('haarcascade_frontalcatface.xml')
else:
    face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt.xml')

cap = cv2.VideoCapture(0)

tempo0 = 0
  
while 1:
    if (time.perf_counter() - tempo0 >= 1800 or tempo0 == 0):
        ret, img = cap.read()

        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) 

        faces = face_cascade.detectMultiScale(gray, 1.3, 5) 
    
        for (x,y,w,h) in faces:
            cv2.rectangle(img,(x,y),(x+w,y+h),(255,255,0),2) 
            roi_gray = gray[y:y+h, x:x+w] 
            roi_color = img[y:y+h, x:x+w] 
            print('Video')
            tempo0 = time.perf_counter()
    
        cv2.imshow('Cat video', img)
    else:
        print(str(1800 - (time.perf_counter() - tempo0)) + ' segundos até a utilização')
    
    k = cv2.waitKey(30) & 0xff
    if k == 27: 
        break
  
# Close the window
cap.release() 
  
# De-allocate any associated memory usage 
cv2.destroyAllWindows()