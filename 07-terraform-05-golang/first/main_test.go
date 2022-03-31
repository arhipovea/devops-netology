package main

import "testing"

func TestConvert(t *testing.T) {
	expected := 3.28
	received := convert(1)
	if received != expected {
		t.Errorf("Error, got: %f, want: %f", received, expected)
	}
}
