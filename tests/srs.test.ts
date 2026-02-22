import { describe, it } from "node:test";
import assert from "node:assert";
import { calculateNextReview, scoreToPerformance } from "../src/utils/srs.ts";

describe("srs", () => {
  describe("calculateNextReview", () => {
    it("should initialize review for new item", () => {
      const performance = 5;
      const result = calculateNextReview(performance);
      assert.strictEqual(result.interval, 1);
      assert.strictEqual(result.repetitions, 1);
      assert.ok(result.easeFactor > 2.5);
      assert.ok(result.nextReview > Date.now());
    });

    it("should handle correct answer (performance >= 3)", () => {
      const performance = 4;
      const previous = {
        questionId: "q1",
        easeFactor: 2.5,
        interval: 1,
        repetitions: 1,
        nextReview: 0
      };
      const result = calculateNextReview(performance, previous);
      assert.strictEqual(result.interval, 6);
      assert.strictEqual(result.repetitions, 2);
    });

    it("should handle incorrect answer (performance < 3)", () => {
      const performance = 2;
      const previous = {
        questionId: "q1",
        easeFactor: 2.5,
        interval: 6,
        repetitions: 2,
        nextReview: 0
      };
      const result = calculateNextReview(performance, previous);
      assert.strictEqual(result.interval, 1);
      assert.strictEqual(result.repetitions, 0);
    });
  });

  describe("scoreToPerformance", () => {
    it("should return 5 for score >= 90", () => {
      assert.strictEqual(scoreToPerformance(100), 5);
      assert.strictEqual(scoreToPerformance(90), 5);
    });
    it("should return 0 for score < 10", () => {
      assert.strictEqual(scoreToPerformance(9), 0);
      assert.strictEqual(scoreToPerformance(0), 0);
    });
  });
});
