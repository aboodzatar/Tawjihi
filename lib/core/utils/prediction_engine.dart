import 'dart:math';
import '../../data/services/local_data_service.dart';

class PredictionResult {
  final double predictedTanafos;
  final double? predictedMowazi;
  final String chance; // "Safe", "High", "Competitive", "Ambitious"
  final String trend; // "Rising", "Falling", "Stable"
  final double confidence; // 0.0 to 1.0

  PredictionResult({
    required this.predictedTanafos,
    this.predictedMowazi,
    required this.chance,
    required this.trend,
    required this.confidence,
  });
}

class PredictionEngine {
  /// Predicts the next year's grade based on historical data
  static PredictionResult calculatePrediction(MajorData major, double studentGrade) {
    final history = major.yearlyData.values.toList();
    history.sort((a, b) => a.year.compareTo(b.year));

    if (history.isEmpty) {
      return PredictionResult(
        predictedTanafos: 0,
        chance: "Unknown",
        trend: "Stable",
        confidence: 0,
      );
    }

    // 1. Weighted Average (More weight to recent years)
    double weightedSum = 0;
    double weightTotal = 0;
    
    for (int i = 0; i < history.length; i++) {
      // Linear weight: oldest year gets 1, newest gets history.length
      double weight = (i + 1).toDouble(); 
      weightedSum += history[i].minTanafos * weight;
      weightTotal += weight;
    }

    double basePrediction = weightedSum / weightTotal;

    // 2. Trend Analysis (last 3 years)
    String trend = "Stable";
    if (history.length >= 2) {
      double recentDiff = history.last.minTanafos - history[history.length - 2].minTanafos;
      if (recentDiff > 0.5) trend = "Rising";
      else if (recentDiff < -0.5) trend = "Falling";
      
      // Apply trend to prediction (conservative adjustment)
      basePrediction += recentDiff * 0.2; 
    }

    // 3. Safety Buffer (0.5 to account for generic yearly fluctuation)
    basePrediction += 0.3;

    // 4. Calculate Mowazi (if data exists)
    double? predictedMowazi;
    final mowaziHistory = history.where((h) => h.minMowazi != null).toList();
    if (mowaziHistory.isNotEmpty) {
      double mSum = 0;
      for (var h in mowaziHistory) mSum += h.minMowazi!;
      predictedMowazi = mSum / mowaziHistory.length;
    }

    // 5. Determine Chance for this student
    String chance = "Competitive";
    double diff = studentGrade - basePrediction;

    if (diff >= 2.0) chance = "Safe";
    else if (diff >= 0.5) chance = "High";
    else if (diff >= -1.0) chance = "Competitive";
    else chance = "Ambitious";

    // 6. Confidence Score (based on data consistency)
    double variance = 0;
    for (var h in history) {
      variance += (h.minTanafos - basePrediction).abs();
    }
    double avgVariance = variance / history.length;
    double confidence = (1.0 - (avgVariance / 10)).clamp(0.5, 0.95);

    return PredictionResult(
      predictedTanafos: double.parse(basePrediction.toStringAsFixed(2)),
      predictedMowazi: predictedMowazi != null ? double.parse(predictedMowazi.toStringAsFixed(2)) : null,
      chance: chance,
      trend: trend,
      confidence: confidence,
    );
  }
}
