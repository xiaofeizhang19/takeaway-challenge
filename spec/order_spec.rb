require 'order'

describe Order do
  it 'should be initialized with an empty array of order' do
    subject = Order.new([])
    expect(subject.order).to be_empty
  end

  describe '#valid' do
    let(:menu_dishes) { [
      Dish.new("dish_1", 9.0),
      Dish.new("dish_2", 12.3),
    ] 
    }

    it 'should fail an empty order' do
      subject = Order.new([])
      expect { subject.valid(menu_dishes) }.to raise_error 'Empty order'
    end

    it 'should fail an order with dishes not available' do
      subject = Order.new([{ name: "dish_random", quantity: 1 }])
      expect { subject.valid(menu_dishes) }.to raise_error 'Dish not in menu'
    end

    it 'should fail an order when some dishes not available' do
      subject = Order.new(
        [
          { name: "dish_1", quantity: 2 },
          { name: "dish_3", quantity: 3 },
        ],
        54
      )
      expect { subject.valid(menu_dishes) }.to raise_error 'Dish not in menu'
    end

    it 'should fail an order if price does not match' do
      subject = Order.new([{ name: "dish_2", quantity: 2 }])
      expect { subject.valid(menu_dishes) }.to raise_error 'Price does not match'
    end

    it 'should validate a good order' do
      subject = Order.new([{ name: "dish_2", quantity: 2 }], 24.6)
      expect { subject.valid(menu_dishes) }.not_to raise_error
    end
  end
end
