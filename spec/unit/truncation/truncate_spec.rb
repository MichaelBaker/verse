# coding: utf-8

require 'spec_helper'

RSpec.describe Verse::Truncation, '.truncate' do
  let(:text) { 'ラドクリフ、マラソン五輪代表に1万m出場にも含み' }

  it 'with zero length' do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(0)).to eq(text)
  end

  it 'with nil length' do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(nil)).to eq(text)
  end

  it 'with equal length' do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(text.length)).to eq(text)
  end

  it 'with truncation' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12)).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it 'without truncation' do
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate(100)).to eq(text)
  end

  it 'truncates text with string separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: ' ')).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it 'truncates text with regex separator' do
    truncation = Verse::Truncation.new(text)
    trailing = '…'
    expect(truncation.truncate(12, separator: /\s/)).to eq("ラドクリフ、マラソン五#{trailing}")
  end

  it 'with custom trailing' do
    truncation = Verse::Truncation.new(text)
    trailing = '... (see more)'
    expect(truncation.truncate(20, trailing: trailing)).to eq("ラドクリフ、#{trailing}")
  end

  it 'correctly calculates with ANSI characters' do
    text = "This is a \e[1m\e[34mbold blue text\e[0m"
    truncation = Verse::Truncation.new(text)
    expect(truncation.truncate).to eq 'This is a bold blue text'
  end
end