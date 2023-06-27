weight_0 = float(input('Starting weight (kg): '))
goal = float(input('Goal weight (kg): '))
weekly_deficit_c = float(input('Weekly calorie deficit: '))

weekly_deficit_kg = weekly_deficit_c/7700

# initialize
wk = 0
weight = weight_0
lost_kg = 0
pct = (lost_kg/weight_0)*100

print('Wk Weight (kg) Lost (kg)    Pct')
print('-- ----------- ---------    ---')
print('{:2d} {:11.1f} {:9.1f} {:5.1f}%'.format(wk, weight, lost_kg, pct))


while weight > goal:

    weight -= weekly_deficit_kg
    lost_kg += weekly_deficit_kg

    if weight <= goal:
        weight = goal
        lost_kg = weight_0 - goal

    pct = (lost_kg/weight_0)*100
    wk += 1

    print('{:2d} {:11.1f} {:9.1f} {:5.1f}%'.format(wk, weight, lost_kg, pct))
