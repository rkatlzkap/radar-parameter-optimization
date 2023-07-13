# radar-parameter-optimization

The project is an industry-academic project that solves the company's requests (measurement of radar sensor
detection accuracy, object recognition in sensor fixed state, object recognition in sensor movement state, 
and analysis of results according to sensor state).


Through experiments, parameters such as maximum detection distance, maximum detection angle, 
and detection accuracy of radar sensors were derived, and the detection degree according to the 
characteristics of the object and the movement state of the object was identified. 

It was confirmed that the radar sensor used in the experiment had a maximum distance of about 10m, 
a maximum angle of about [-45, +45]deg, and each MAE figure was measured at 5.39cm, 4.87[deg]. 
In addition, it was confirmed that the detection priority was higher than when the object was in motion, 
and if the object was in motion, the RCS (signal reflection intensity) level was detected in the order of high. 

In conclusion, the minimum relative speed when either the sensor or the object approaches was measured 
at -0.4 m/s, and based on this result, the direction of use of the radar sensor was described.
