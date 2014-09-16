require "spec_helper"

describe PromisePay::Country do
  it "converts a two letter country code to three letters" do
    expect(PromisePay::Country.code_for('AU')).to eq 'AUS'
  end

  it "leaves three letter codes unchanged" do
    expect(PromisePay::Country.code_for('BEL')).to eq 'BEL'
  end
end