require_relative '../../app/helpers/slugr'

describe Slugr do

  it 'should be stable' do
    expect(Slugr.exec()).to be == ''
    expect(Slugr.exec(nil)).to be == ''
  end
  
  it 'should turn to lower case' do
    expect(Slugr.exec 'TODO').to be == 'todo'
  end

  it 'should remove spaces around hyphen' do
    expect(Slugr.exec ' - ').to be == '-'
  end

  it 'should turn spaces to hyphen' do
    expect(Slugr.exec 'x y').to be == 'x-y'
  end

  it 'should process to a whole slug' do
    expect(Slugr.exec 'X - Y Z - A').to be == 'x-y-z-a'
  end

end