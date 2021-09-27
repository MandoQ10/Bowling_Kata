class Game 
    def initialize()
        @rolls = Array.new(20)
        @current_Roll = 0 
        @score = 0
    end 

    def roll(pins)
        @rolls[@current_Roll] = pins
        @current_Roll += 1
    end

    def score 
        frame_Index = 0 
        frame = 0 

        while frame < 10
            if isSpare(frame_Index)
                @score += 10 + @rolls[frame_Index + 2]
                frame_Index += 2
            elsif isStrike(frame_Index)
                @score += 10 + @rolls[frame_Index + 1] + @rolls[frame_Index + 2]
                frame_Index += 1
            else 
                @score += @rolls[frame_Index] + @rolls[frame_Index + 1]
                frame_Index += 2
            end
            frame += 1
        end
        return @score
    end

    private 

    def isSpare(frame_Index)
        return (@rolls[frame_Index] + @rolls[frame_Index + 1]) == 10
    end

    def isStrike(frame_Index)
        return @rolls[frame_Index] == 10
    end
end

describe Game do
    @game

    def set_up 
        @game = Game.new
    end

    def rollMany(rolls, pins)
        rolls.times do |i|
            @game.roll(pins)
        end
    end

    context "Score Test Suite: " do 

        it "Neither a spare or a stike should return correct number of pins scored" do 
            set_up

            @game.roll(8)
            @game.roll(1)
            rollMany(18,0)

            expect(@game.score).to eq 9
        end

        it "Rolling spare followed by a roll of 2 should return 14" do 
            set_up

            @game.roll(5)
            @game.roll(5)
            @game.roll(2)
            rollMany(17,0)

            expect(@game.score).to eq 14
        end

        it "testing rolling all ones" do 
            set_up

            rollMany(20,1)

            expect(@game.score).to eq 20
        end
        
        it "Rolling a strike followed by a rolling a 9, returning a score 28" do 
            set_up

            @game.roll(10)
            @game.roll(8)
            @game.roll(1)
            rollMany(17,0)

            expect(@game.score).to eq 28
        end    

        it "Rolling two strikes in a row follwed by 7, should return 46" do 
            set_up

            @game.roll(10)
            @game.roll(10)
            @game.roll(2)
            @game.roll(5)
            rollMany(16,0)

            expect(@game.score).to eq 46
        end       
    end
end 