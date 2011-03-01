require('spec_helper')

describe(I18nColumn::Base) do
  before(:each) do
    I18n.locale = :en
  end
  
  context('with no translations') do
    before(:each) do
      @node = Node.new
    end
    
    describe('#name') do
      it('should return nil') do
        @node.name.should(be_nil)
      end
    end
    
    describe('#name=') do
      it('should set the english translation') do
        @node.name = 'Home'
        @node.name.should == 'Home'
      end
    end
  end
  
  context('with an english translation') do
    before(:each) do
      @node = Node.create!(:name => 'Home')
      @node.reload
    end
    
    describe('#name') do
      it('should return the english translation') do
        @node.name.should == 'Home'
      end
    end
    
    describe('#name=') do
      it('should override the english translation') do
        @node.name = 'Home overridden'
        @node.name.should == 'Home overridden'
      end
      
      it('should set the german translation') do
        I18n.locale = :de
        @node.name = 'Zuhause'
        @node.name.should == 'Zuhause'
      end
    end
  end
  
  context('with an english and german translation') do
    before(:each) do
      @node = Node.create!(:name => 'Home')
      I18n.locale = :de
      @node.update_attribute(:name, 'Zuhause')
      @node.reload
    end
    
    describe('#name') do
      it('should return the english translation') do
        I18n.locale = :en
        @node.name.should == 'Home'
      end
      
      it('should return the german translation') do
        I18n.locale = :de
        @node.name.should == 'Zuhause'
      end
    end
    
    describe('#name=') do
      it('should set the english translation') do
        I18n.locale = :en
        @node.name = 'Home overridden'
        @node.name.should == 'Home overridden'
        I18n.locale = :de
        @node.name.should == 'Zuhause'
      end
      
      it('should set the german translation') do
        I18n.locale = :de
        @node.name = 'Zuhause ueberschrieben'
        @node.name.should == 'Zuhause ueberschrieben'
        I18n.locale = :en
        @node.name.should == 'Home'
      end
    end
  end
  
  describe('#fname') do
    it('should call method name') do
      node = Node.new
      node.should_receive(:name)
      node.fname
    end
  end
  
  describe('#fname=') do
    it('should call method name=') do
      node = Node.new
      node.should_receive(:name=).with('translation')
      node.fname = 'translation'
    end
  end
end
