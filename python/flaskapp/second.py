# import app

# app.main()

# print(f"second.py module name is {__name__}")

# def add(n1, n2):
#     return n1 + n2

# def sub(n1, n2):
#     return n1 - n2

# def multiply(n1, n2):
#     return n1 * n2

# def div(n1, n2):
#     return n1 / n2

# def calculate(calc, n1, n2):
#     return calc(n1, n2)

# result = calculate(multiply, 3, 4)
# print(result)

def out():
    print("Outside function")
    a = 3

    def inner():
        print("inner function")

    if 3 - a == 1:
        return inner()

out()