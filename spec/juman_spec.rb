# coding: utf-8

require 'rspec'
require 'juman'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__))}/bin:#{ENV['PATH']}"

describe Juman::Morpheme do
  context 'when initialized with a line of the result of "見る"' do
    subject { Juman::Morpheme.new(
        "見る みる 見る 動詞 2 * 0 母音動詞 1 基本形 2 \"情 報\"\n") }
    describe '#surface' do
      subject { super().surface }
      it { is_expected.to eq '見る' }
    end

    describe '#pronunciation' do
      subject { super().pronunciation }
      it { is_expected.to eq 'みる' }
    end

    describe '#base' do
      subject { super().base }
      it { is_expected.to eq '見る' }
    end

    describe '#pos' do
      subject { super().pos }
      it { is_expected.to eq '動詞' }
    end

    describe '#pos_id' do
      subject { super().pos_id }
      it { is_expected.to be 2 }
    end

    describe '#pos_spec' do
      subject { super().pos_spec }
      it { is_expected.to be_nil }
    end

    describe '#pos_spec_id' do
      subject { super().pos_spec_id }
      it { is_expected.to be 0 }
    end

    describe '#type' do
      subject { super().type }
      it { is_expected.to eq '母音動詞' }
    end

    describe '#type_id' do
      subject { super().type_id }
      it { is_expected.to be 1 }
    end

    describe '#form' do
      subject { super().form }
      it { is_expected.to eq '基本形' }
    end

    describe '#form_id' do
      subject { super().form_id }
      it { is_expected.to be 2 }
    end

    # describe '#info' do
    #   subject { super().info }
    #   it { is_expected.to eq '情 報' }
    # end
  end
end
describe Juman::Result do
  context 'when initialized with an Enumerator of the result of "見る"' do
    before { @result = Juman::Result.new(
      ["見る みる 見る 動詞 2 * 0 母音動詞 1 基本形 2 \"情 報\""].to_enum) }
    subject { @result }
    it { is_expected.to be_an Enumerable }
    it { is_expected.to respond_to :each }
    it { is_expected.to respond_to :[] }
    it { is_expected.to respond_to :at }
    describe '#[]' do
      context 'when argument 0' do
        subject { @result[0] }
        it 'should return Juman::Morpheme' do
          is_expected.to be_an_instance_of Juman::Morpheme
        end
      end
    end
    describe '#each' do
      context 'without block' do
        subject { @result.each }
        it 'should return Enumerator' do
          is_expected.to be_an_instance_of Enumerator
        end
      end
      context 'with block' do
        subject { @result.each{} }
        it 'should return self' do
          is_expected.to be @result
        end
      end
    end
  end
end
describe Juman::Process do
  before { @process = Juman::Process.new('juman -e2 -B') }
  describe '#parse_to_enum' do
    context 'when argument "見る"' do
      subject { @process.parse_to_enum('見る') }
      it 'should return Enumerator' do
        is_expected.to be_an_instance_of Enumerator
      end
    end
  end
end
describe Juman do
  before { @juman = Juman.new }
  subject { @juman }
  it { is_expected.to respond_to :analyze }
  describe '#analyze' do
    context 'when argument "見る"' do
      before { @result = @juman.analyze('見る') }
      it 'should return Juman::Result' do
        expect(@result).to be_an_instance_of Juman::Result
      end
      describe 'returned Juman::Result' do
        subject { @result }
        describe '#[]' do
          context 'when argument 0' do
            it 'should return Juman::Morpheme' do
              expect(@result[0]).to be_an_instance_of Juman::Morpheme
            end
          end
        end
      end
    end
  end
end

describe Juman do
  before { @juman = Juman.new(juman_command: ENV['JUMAN_CMD'] || '/opt/juman-7.01/bin/juman') }
  subject { @juman }
  it { is_expected.to respond_to :analyze }
  describe '#analyze' do
    context 'when analyze sample.txt' do
      before {
        sample_txt = File.expand_path(File.join(File.dirname(__FILE__), 'sample.txt'))
        @result = @juman.analyze(IO.read(sample_txt))
      }
      it 'should return Juman::Result' do
        expect(@result).to be_an_instance_of Juman::Result
      end
      describe 'returned Juman::Result' do
        subject { @result }
        describe '#[]' do
          context 'when argument 0' do
            it 'should return Juman::Morpheme' do
              expect(@result[0]).to be_an_instance_of Juman::Morpheme
            end
            describe Juman::Morpheme do
              subject { @result[0] }
              describe '#surface' do
                subject { super().surface }
                it { is_expected.to eq 'カサつく' }
              end
              describe '#pronunciation' do
                subject { super().pronunciation }
                it { is_expected.to eq 'カサつく' }
              end
            end
          end
        end
      end
    end
  end
end
