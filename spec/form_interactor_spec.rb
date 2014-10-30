require "spec_helper"

describe FormInteractor do
  def build_form(&block)
    Class.new.send(:include, described_class).tap do |form_class|
      form_class.class_eval(&block) if block
    end
  end

  # subject(:form) { Class.new.send(:include, described_class) }
  let(:form_class) { build_form }

  describe "class macros" do
    describe ".form_model_name=" do
    end

    describe ".interactor=" do
    end

    describe ".attribute" do
    end
  end

  describe "ActiveModel form behavior" do
    describe ".new" do
      let(:form_class) {
        build_form do
          attribute :name
        end
      }

      it "sets a hash of attributes" do
        expect(form_class.new(name: "Taylor").name).to eq "Taylor"
      end

      it "raises an error for undeclared attributes" do
        expect { form_class.new(occupation: "Entertainer") }.to raise_error(NoMethodError)
      end
    end

    describe ".model_name" do
    end

    describe "#valid?" do
    end

    describe "#errors" do
    end
  end

  describe ".call" do
  end

  describe "#to_context" do
  end

  describe "#attributes" do
  end

  describe "#result" do
  end

  describe "#success?" do
  end

  describe "#failure?" do
  end
end
