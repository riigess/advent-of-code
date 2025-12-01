class PartOne:
    def turn_left(self, pos, by:int):
        pos -= by
        if pos < 0:
            pos %= 100 #Rotate back to positives
        return pos

    def turn_right(self, pos, by:int):
        pos += by
        if pos >= 100:
            pos %= 100
        return pos

    def solve(self, filename:str="part1.txt"):
        bounds = list(range(0, 100))
        pos = 50
        zero_count = 0

        with open(filename, 'r') as f:
            d = f.read()

        for line in d.split('\n')[:-1]:
            if line[0] == 'L':
                pos = self.turn_left(pos, int(line[1:]))
            if line[0] == 'R':
                pos = self.turn_right(pos, int(line[1:]))
            if pos == 0:
                zero_count += 1

        print("final:", pos)
        print('zero_count:', zero_count)


zero_click_count = 0
#Part Two
class PartTwo(PartOne):
    def turn_left(self, pos, by:int):
        global zero_click_count
        pos -= by
        if pos < 0:
            zero_click_count += abs(pos // 100)
            pos %= 100
        return pos

    def turn_right(self, pos, by:int):
        global zero_click_count
        pos += by
        if pos >= 100:
            zero_click_count += abs(pos // 100)
            pos %= 100
        return pos

if __name__ == "__main__":
    #Part One
    print("Day 1:")
    part_one = PartOne()
    part_one.solve()

    print("\nDay 2:")
    part_two = PartTwo()
    part_two.solve(filename="part2.txt")
    print("zero_click_count:", zero_click_count)
