# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyPager do
  before(:all) do
    30.times do |i|
      Post.create(title: "Title_#{i}", body: "Body_#{i}")
    end
    EasyPager.configure do |config|
      config.default_per = 20
    end
  end
  it 'has a version number' do
    expect(EasyPager::VERSION).not_to be nil
  end

  describe 'page' do
    let(:page) { 1 }
    let(:records) { Post.all.page(page) }

    context 'no pagination' do
      let(:records) { Post.all }
      describe 'offset' do
        subject { records.offset_value }
        it { is_expected.to eq nil }
      end
      describe 'limit' do
        subject { records.limit_value }
        it { is_expected.to eq nil }
      end
      describe 'current_page' do
        subject { records.current_page }
        it { is_expected.to eq nil }
      end
      describe 'total_count' do
        subject { records.total_count }
        it { is_expected.to eq 30 }
      end
      describe 'total_pages' do
        subject { records.total_pages }
        it { is_expected.to eq nil }
      end
      describe 'count' do
        subject { records.count }
        it { is_expected.to eq 30 }
      end
    end

    context 'page is nil' do
      subject { records }

      let(:page) { nil }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'page is 1' do
      let(:page) { 1 }
      describe 'offset' do
        subject { records.offset_value }
        it { is_expected.to eq 0 }
      end
      describe 'limit' do
        subject { records.limit_value }
        it { is_expected.to eq 20 }
      end
      describe 'current_page' do
        subject { records.current_page }
        it { is_expected.to eq 1 }
      end
      describe 'total_count' do
        subject { records.total_count }
        it { is_expected.to eq 30 }
      end
      describe 'total_pages' do
        subject { records.total_pages }
        it { is_expected.to eq 2 }
      end
      describe 'count' do
        subject { records.count }
        it { is_expected.to eq 20 }
      end
    end

    context 'page is 2' do
      let(:page) { 2 }
      describe 'offset' do
        subject { records.offset_value }
        it { is_expected.to eq 20 }
      end
      describe 'limit' do
        subject { records.limit_value }
        it { is_expected.to eq 20 }
      end
      describe 'current_page' do
        subject { records.current_page }
        it { is_expected.to eq 2 }
      end
      describe 'total_count' do
        subject { records.total_count }
        it { is_expected.to eq 30 }
      end
      describe 'total_pages' do
        subject { records.total_pages }
        it { is_expected.to eq 2 }
      end
      describe 'count' do
        subject { records.count }
        it { is_expected.to eq 10 }
      end
    end
  end

  describe 'per' do
    let(:page) { 1 }
    let(:per) { 1 }
    let(:records) { Post.all.page(page).per(per) }
    context 'per is 1' do
      let(:per) { 1 }
      describe 'offset' do
        subject { records.offset_value }
        it { is_expected.to eq 0 }
      end
      describe 'limit' do
        subject { records.limit_value }
        it { is_expected.to eq 1 }
      end
      describe 'current_page' do
        subject { records.current_page }
        it { is_expected.to eq 1 }
      end
      describe 'total_count' do
        subject { records.total_count }
        it { is_expected.to eq 30 }
      end
      describe 'total_pages' do
        subject { records.total_pages }
        it { is_expected.to eq 30 }
      end
      describe 'count' do
        subject { records.count }
        it { is_expected.to eq 1 }
      end
    end
    context 'per is 2' do
      let(:per) { 2 }
      describe 'offset' do
        subject { records.offset_value }
        it { is_expected.to eq 0 }
      end
      describe 'limit' do
        subject { records.limit_value }
        it { is_expected.to eq 2 }
      end
      describe 'current_page' do
        subject { records.current_page }
        it { is_expected.to eq 1 }
      end
      describe 'total_count' do
        subject { records.total_count }
        it { is_expected.to eq 30 }
      end
      describe 'total_pages' do
        subject { records.total_pages }
        it { is_expected.to eq 15 }
      end
      describe 'count' do
        subject { records.count }
        it { is_expected.to eq 2 }
      end
    end
  end
end
