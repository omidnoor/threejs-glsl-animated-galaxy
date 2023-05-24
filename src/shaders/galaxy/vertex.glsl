
uniform float uTime;
uniform float uSize;

attribute float aScale;
attribute vec3 aRandomness;


varying vec3 vColor;

void main(){
        vec4 modelPosition = modelMatrix * vec4(position, 1.0);
        
        // Spin
        float angle = atan(modelPosition.x, modelPosition.z);
        float distanceToCenter = distance(modelPosition.xz, vec2(0.0));
        float angleOffset = (1.0 / distanceToCenter) * uTime * 0.2;
        angle += angleOffset;  

        modelPosition.x = cos(angle) * distanceToCenter;
        modelPosition.z = sin(angle) * distanceToCenter;

        // Randomness
        modelPosition.xyz += aRandomness;

        vec4 viewPosition = viewMatrix * modelPosition;
        vec4 projectionPosition = projectionMatrix * viewPosition;

        gl_Position = projectionPosition;
        gl_PointSize = uSize  * aScale;
        gl_PointSize *= ( 1.0 / - viewPosition.z );



        /**
        * Color
        */
        vColor = color;
    }