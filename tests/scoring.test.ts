import { describe, it } from "node:test";
import assert from "node:assert";
import { calculateScore } from "../src/utils/scoring.ts";

describe("calculateScore", () => {
  it("should return 100 for exact keyword matches", () => {
    const transcription = "voltage equals current times resistance";
    const keywords = ["Voltage", "Current", "Resistance"];
    const score = calculateScore(transcription, keywords);
    assert.strictEqual(score, 100);
  });

  it("should be case insensitive", () => {
    const transcription = "VOLTAGE equals Current times RESISTANCE";
    const keywords = ["voltage", "current", "resistance"];
    const score = calculateScore(transcription, keywords);
    assert.strictEqual(score, 100);
  });

  it("should return 0 for no matches", () => {
    const transcription = "hello world";
    const keywords = ["Voltage", "Current"];
    const score = calculateScore(transcription, keywords);
    assert.strictEqual(score, 0);
  });

  it("should handle partial matches", () => {
    const transcription = "voltage equals something else";
    const keywords = ["Voltage", "Current"];
    const score = calculateScore(transcription, keywords);
    assert.strictEqual(score, 50);
  });

  it("should handle empty transcription", () => {
    const transcription = "";
    const keywords = ["Voltage"];
    const score = calculateScore(transcription, keywords);
    assert.strictEqual(score, 0);
  });
});
