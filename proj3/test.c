#include <stdint.h>  // for int32_t
#include <stdio.h>   // for printf (optional, for testing)

float Q_rsqrt(float number)
{
    int32_t i;
    float x2, y;
    const float threehalfs = 1.5F;

    // Step 1: Compute half of the input number
    x2 = number * 0.5F;
    
    // Step 2: Initial guess for the inverse square root
    y = number;
    
    // Step 3: Bit-level manipulation to get the initial approximation
    i = * (int32_t *) &y;             // Reinterpret float bits as an int
    // interpret this bit pattern as an IEEE 32-bit floating-point number and print
    printf("The bit pattern of the float number is: %x\n", i);

    
    i = 0x5f3759df - (i >> 1);        // Magic number and shifting
    y = * (float *) &i;               // Reinterpret int bits back as float
    
    // Step 4: First iteration of Newton's method
    y = y * (threehalfs - (x2 * y * y));   // Perform the approximation

    // Step 5: Optional second iteration (commented out)
    // y = y * (threehalfs - (x2 * y * y)); // Can improve accuracy, but usually not needed

    return y;
}

int main() {
    float number = 0.15625;
    float result = Q_rsqrt(number);
    printf("The fast inverse square root of %f is approximately %f\n", number, result);
    return 0;
}
// 