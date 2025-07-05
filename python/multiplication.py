# num = int(input("enter no : "))   
# x = 1
# while x <= num:
#     print(f"Multiplaction of {x}")
#     y = 1
#     while y <= 12:
#         print(f"{x} x {y} = {x * y}")
#         y += 1        
#     print()
#     x += 1

def multiplication_table(num):
    x = 1
    while x <= num:
        print("------------------------------")
        print(f"Multiplication Table of {x}")
        print("------------------------------")
        y = 1
        while y <= 12:
            print(f"{x} x {y} = {x*y}")
            y += 1
        print()
        x += 1 

multiplication_table(int(input("Enter your number :")))
# print(multiplication_table)
