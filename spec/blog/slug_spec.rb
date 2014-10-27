require 'rails_helper'

describe Blog::Slugr do

  it 'should be stable' do
    expect(Blog::Slugr.exec()).to be == ''
    expect(Blog::Slugr.exec(nil)).to be == ''
  end
  
  it 'should turn to lower case' do
    expect(Blog::Slugr.exec 'TODO').to be == 'todo'
  end

  it 'should remove spaces around hyphen' do
    expect(Blog::Slugr.exec ' - ').to be == '-'
  end

  it 'should turn spaces to hyphen' do
    expect(Blog::Slugr.exec 'x y').to be == 'x-y'
  end

  it 'should turn umlauts to two characters' do
    expect(Blog::Slugr.exec 'äöüß').to be == 'aeoeuess'
  end
  
  it 'should remove all special chars' do
    expect(Blog::Slugr.exec '^!"§$%&/()=?`´[],;.:_+*#\'x').to be == 'x'
  end

  it 'should process to a whole slug' do
    expect(Blog::Slugr.exec 'X - Y Z - A').to be == 'x-y-z-a'
  end

end