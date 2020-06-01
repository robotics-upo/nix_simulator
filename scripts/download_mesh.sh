#! /bin/bash
n="pico_flexx"

# Download the mesh resources:
for sensor in ${n}_l ${n}_r ${n}_f ${n}_b 
do
    echo Adding sensor $sensor
    mkdir -p models/sensors/$sensor
    cd models/sensors/$sensor
    cp -r ../$n/* .
    sed -i s/$n/$sensor/g model.config
    sed -i s/$n/$sensor/g $n.sdf
    mv $n.sdf $sensor.sdf
    cd ../../..
done
    
echo "Sensors duplicated successfully."

