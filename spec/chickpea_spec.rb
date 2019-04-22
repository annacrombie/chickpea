RSpec.describe Chickpea do
  it 'has a version number' do
    expect(Chickpea::VERSION).not_to be nil
  end

  let(:stash) {
    Chickpea.new(
      a: {
        b: {
          c: {
            d: 1
          }
        },
        bb: false
      }
    )
  }

  it 'has working accessors' do
    expect(stash.a.b.c.d).to eq(1)
    expect(stash.a.bb?).to be(false)
    expect(stash.a).not_to respond_to(:b=)
  end

  it 'allows you to set some attributes' do
    expect { stash.a.bb = 1 }.to raise_exception(TypeError)
    expect { stash.a.bb = true }.not_to raise_exception
    expect(stash.a.bb).to be(true)
    expect { stash.a.b.c.d = 1.1 }.to raise_exception(TypeError)
    expect { stash.a.b.c.d = 3 }.not_to raise_exception
    expect(stash.a.b.c.d).to eq(3)
  end

  it 'can be converted to a hash' do
    expect(stash.a.b.c.to_h).to eq(d: 1)
    expect(stash.a.b.to_h).to eq(c: { d: 1 })
  end

  it 'can merge with a hash' do
    stash.a.merge!(b: { c: { d: 5 } })
    expect(stash.a.b.c.d).to eq(5)
  end
end
