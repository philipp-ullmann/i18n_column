require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe(I18nColumn::Base) do
  before(:each) do
    setup_db
  end
  
  after(:each) do
    teardown_db
  end
  
  context('with no translation') do
    before(:each) do
      I18nColumn::Language.current_lang = 'en'
      @node = Node.new
    end
    
    describe('#name') do
      it('returns nil') do
        @node.name.should(be_nil)
      end
    end
    
    describe('#name=') do
      it('sets the english name') do
        @node.name = 'Home'
        @node.name.should == 'Home'
      end
    end
  end
  
  context('with an english name only') do
    before(:each) do
      I18nColumn::Language.current_lang = 'en'
      @node = Node.create!(:name => 'Home')
    end
    
    describe('#name') do
      it('returns the english name') do
        @node.name.should == 'Home'
      end
    end
    
    describe('#name=') do
      it('overrides the english name') do
        @node.name = 'Home overridden'
        @node.name.should == 'Home overridden'
      end
      
      it('translates the name into german') do
        I18nColumn::Language.current_lang = 'de'
        @node.name = 'Zuhause'
        @node.name.should == 'Zuhause'
      end
    end
  end
  
  context('with an english and german name') do
    before(:each) do
      I18nColumn::Language.current_lang = 'en'
      @node = Node.create!(:name => 'Home')
      I18nColumn::Language.current_lang = 'de'
      @node.update_attribute(:name, 'Zuhause')
    end
    
    describe('#name') do
      it('returns the english name') do
        I18nColumn::Language.current_lang = 'en'
        @node.name.should == 'Home'
      end
      
      it('returns the german name') do
        I18nColumn::Language.current_lang = 'de'
        @node.name.should == 'Zuhause'
      end
    end
    
    describe('#name=') do
      it('overrides the english name only') do
        I18nColumn::Language.current_lang = 'en'
        @node.name = 'Home overridden'
        @node.name.should == 'Home overridden'
        I18nColumn::Language.current_lang = 'de'
        @node.name.should == 'Zuhause'
      end
      
      it('overrides the german name only') do
        I18nColumn::Language.current_lang = 'de'
        @node.name = 'Zuhause ueberschrieben'
        @node.name.should == 'Zuhause ueberschrieben'
        I18nColumn::Language.current_lang = 'en'
        @node.name.should == 'Home'
      end
    end
  end
end
