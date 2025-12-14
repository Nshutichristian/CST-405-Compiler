/* ULTIMATE CALCULATOR DEMO
 * Shows compiler handling complex nested expressions
 * with proper operator precedence and parentheses
 */

int main() {
    int num1;
    int num2;
    int num3;
    int result;

    /* Interactive calculator */
    read(num1);
    read(num2);
    read(num3);

    /* Simple operations */
    result = num1 + num2;
    print(result);

    result = num1 - num2;
    print(result);

    result = num1 * num2;
    print(result);

    result = num1 / num2;
    print(result);

    /* Complex expression 1: (a + b) * c */
    result = (num1 + num2) * num3;
    print(result);

    /* Complex expression 2: (a * b) + (c * a) - (b / num3) */
    result = (num1 * num2) + (num3 * num1) - (num2 / num3);
    print(result);

    /* Complex expression 3: Nested parentheses */
    /* ((a + b) * (c - a)) / b */
    result = ((num1 + num2) * (num3 - num1)) / num2;
    print(result);

    /* Super complex expression demonstration */
    /* (1 + 2) * 3 - 9 / 3 + 5 * 2 */
    result = (1 + 2) * 3 - 9 / 3 + 5 * 2;
    print(result);

    /* Mega complex: ((12 + 8) * (5 - 2)) / (3 + 1) */
    result = ((12 + 8) * (5 - 2)) / (3 + 1);
    print(result);

    /* Ultimate complexity: (10 + 5 * 2) - (20 / 4) + ((3 + 2) * (6 - 1)) */
    result = (10 + 5 * 2) - (20 / 4) + ((3 + 2) * (6 - 1));
    print(result);

    return 0;
}
