require 'spec_helper'

describe "Working with Regular expressions" do
  it "matches character string" do
    my_regex = /foo/
    match = %w{ afoot catfoot dogfoot fanfoot
    foody foolery foolish fooster footage
    foothot footle footpad footway hotfoot
    jawfoot mafoo nonfood padfoot prefool
    sfoot unfool }

    do_not_match = %w{ Atlas Aymoro Iberic Mahran Ormazd Silipan
    altared chandoo crenel crooked fardo folksy forest hebamic
    idgah manlike marly palazzi sixfold tarrock unfold }

    match.each do |word|
      expect(my_regex).to match(word)
    end

    do_not_match.each do |word|
      expect(my_regex).to_not match(word)
    end
  end

  it "uses anchors for matching" do
    my_regex = /ick$/ #terminating ick -- even if is ick and then end of line

    match = %w{ Mick Rick allocochick backtrick bestick
    candlestick counterprick heartsick lampwick
    lick lungsick potstick quick rampick
    rebrick relick seasick slick tick
    unsick upstick }

    do_not_match = %w{ Kickapoo Nickneven Rickettsiales
    billsticker borickite chickell fickleness
    finickily kilbrickenite lickpenny mispickel
    quickfoot quickhatch ricksha rollicking
    slapsticky snickdrawing sunstricken tricklingly
    unlicked unnickeled }

    match.each do |word|
      expect(my_regex).to match(word)
    end

    do_not_match.each do |word|
      expect(my_regex).to_not match(word)
    end
  end

  it "Uses ranges for matching" do
    my_regex = /[a-f]{4}/ # looks like 4 letter strings that are between a and f letters-wise
    match = %w{ abac accede adead babe
    bead bebed bedad bedded bedead bedeaf
    caba caffa dace dade daff dead deed deface
    faded faff feed }

    do_not_match = %w{ beam buoy canjac chymia
    corah cupula griece hafter idic lucy martyr
    matron messrs mucose relose sonly tegua
    threap towned widish yite }

    match.each do |word|
      expect(my_regex).to match(word)
    end

    do_not_match.each do |word|
      expect(my_regex).to_not match(word)
    end
  end

  context "email addresses" do
    it "matches one @ symbols" do
      my_regex = /@/ # has to have @

      match = %w{steven@flatironschool.com john.doe@example.com phil@example.co.uk }
      do_not_match = ["Steven Nunez", "Rose Weixel", "Deniz Unat"]

      match.each do |word|
        expect(my_regex).to match(word)
      end

      do_not_match.each do |word|
        expect(my_regex).to_not match(word)
      end
    end

    it "matches character before and the @ symbols" do
      my_regex = /\w@/

      match = %w{steven@flatironschool.com john.doe@example.com phil@example.co.uk }
      do_not_match = %w{ "user at example.com", "@example.com" }

      match.each do |word|
        expect(my_regex).to match(word)
      end

      do_not_match.each do |word|
        expect(my_regex).to_not match(word)
      end
    end

    it "matches character before, after and the @ symbols" do
      my_regex = /.@/ # redo this one

      match = %w{steven@flatironschool.com john.doe@example.com phil@example.co.uk }
      do_not_match = %w{ "user at example.com", "Steven Nunez flatironschool.com"}

      match.each do |word|
        expect(my_regex).to match(word)
      end

      do_not_match.each do |word|
        expect(my_regex).to_not match(word)
      end
    end


    it "matches valid email address" do
      # Don't use the crazy one from the RFC!
      # has to have first part,@, then word, then .com or .co.uk
      # can only have one @
      # I totally googled that...  http://stackoverflow.com/questions/201323/using-a-regular-expression-to-validate-an-email-address?rq=1
      my_regex = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[com|co.uk]+$/

      # /d+ at least one digit
      # .* of any character
      # @ 
      # .com? -- m would be considered optional
      # matches .\sabc -- . and then any blank numbers of spaces and then abc
      # ^Mission: successful$ Matches this exact string, specified by beginning and and
      # ^(.+).pdf$ any characters in the beginning, before .pdf extension

      match = %w{steven@flatironschool.com john.doe@example.com phil@example.co.uk }
      do_not_match = ["steven@flatironschool", "user at example.com", "user@example.com@example.com"]

      match.each do |word|
        expect(my_regex).to match(word)
      end

      do_not_match.each do |word|
        expect(my_regex).to_not match(word)
      end
    end
  end

  context "The scan method" do
    it "matches valid US phone numbers regardless of format" do
      my_regex = /\d/
      match = ["702-386-5397", "2128675309", "(212) 867-5309"]
      do_not_match = ["123", "this isn't a number", "12345678900000", "abcdefghij", "123456789a"]

      match.each do |word|
        expect(word.scan(my_regex).length). to eq(10)
      end

      do_not_match.each do |word|
        expect(word.scan(my_regex).length).to_not eq(10)
      end
    end
  end
end
