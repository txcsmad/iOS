#include <stdio.h>

typedef struct {
    int   anInt;
    float aFloat;
    const char *aChar;
} SomeStruct; 

float multiply(SomeStruct s) {
    printf("String: %s\n", s.aChar);
    return s.anInt * s.aFloat;
}

int main(int argc, char **argv) {
    SomeStruct s;
    s.anInt = 2;
    s.aFloat = 3.14;
    s.aChar = "hello";
    float result = multiply(s);
    printf("Result: %.3f\n", result);
    return 0;
}