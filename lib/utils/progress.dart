class Progress {
  // =========================
  // ARRAY PROGRESS
  // =========================

  static bool arrayLearnCompleted = false;

  static bool arrayAnimateUnlocked = false;
  static bool arrayAnimateCompleted = false;

  static bool arrayMasterUnlocked = false;
  static bool arrayMasterCompleted = false;

  static void markMasterCompleted() {
    arrayMasterCompleted = true;
  }

  // =========================
  // LINKED LIST PROGRESS
  // =========================

  static bool linkedListLearnCompleted = false;

  static bool linkedListAnimateUnlocked = false;
  static bool linkedListAnimateCompleted = false;

  static bool linkedListMasterUnlocked = false;
  static bool linkedListMasterCompleted = false;

  static void markLinkedListLearnCompleted() {
    linkedListLearnCompleted = true;
    linkedListAnimateUnlocked = true;
  }

  static void markLinkedListAnimateCompleted() {
    linkedListAnimateCompleted = true;
    linkedListMasterUnlocked = true;
  }

  static void markLinkedListMasterCompleted() {
    linkedListMasterCompleted = true;
  }

  // =========================
  // STACK PROGRESS
  // =========================

  static bool stackLearnCompleted = false;
  static bool stackAnimateUnlocked = false;
  static bool stackAnimateCompleted = false;
  static bool stackMasterUnlocked = false;
  static bool stackMasterCompleted = false;

  static void markStackLearnCompleted() {
    stackLearnCompleted = true;
    stackAnimateUnlocked = true;
  }

  static void markStackAnimateCompleted() {
    stackAnimateCompleted = true;
    stackMasterUnlocked = true;
  }

  static void markStackMasterCompleted() {
    stackMasterCompleted = true;
  }
}