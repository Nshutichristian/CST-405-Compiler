/* Advanced Calculator - Complex Expression Demo */

int main() {
    int a;
    int b;
    int c;
    int result;

    /* Get input numbers */
    read(a);
    read(b);
    read(c);

    /* Test 1: Simple addition */
    result = a + b;
    print(result);

    /* Test 2: Subtraction */
    result = a - b;
    print(result);

    /* Test 3: Multiplication */
    result = a * b;
    print(result);

    /* Test 4: Division */
    result = a / b;
    print(result);

    /* Test 5: Complex expression with precedence */
    /* (a + b) * c - a / b */
    result = (a + b) * c - a / b;
    print(result);

    /* Test 6: Nested parentheses */
    /* ((a + b) * (c - a)) / b */
    result = ((a + b) * (c - a)) / b;
    print(result);

    /* Test 7: Multiple operations */
    /* a * b + c * a - b / c */
    result = a * b + c * a - b;
    print(result);

    return 0;
}
