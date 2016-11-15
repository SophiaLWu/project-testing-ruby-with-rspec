# Takes a string and shift factor and outputs the Caesar ciphered string
def caesar_cipher(str, shift_factor)
  letters = str.split("")
  shift_factor %= 26

  letters = letters.map do |letter|
    if letter =~ /[a-zA-Z]/
      curr_ord = letter.ord
      new_ord = curr_ord + shift_factor

      if (letter =~ /[A-Z]/ && new_ord > 90) || 
         (letter =~ /[a-z]/ && new_ord > 122)
        new_ord -= 26
      end 

      letter = new_ord.chr
    end
    letter
  end

  letters.join

end


# Tests
# puts caesar_cipher("What a string!", 5) === "Bmfy f xywnsl!"
# puts caesar_cipher("abcdefghijklmnopqrstuvwxyz", 27) === 
#                    "bcdefghijklmnopqrstuvwxyza"
# puts caesar_cipher("GOOD MORNING ! ! !", 20) === "AIIX GILHCHA ! ! !"
# puts caesar_cipher("blah blah", 29) === caesar_cipher("blah blah", 3)
