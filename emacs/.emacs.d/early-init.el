;;; early-init.el ---                                -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Thomas Schimper

;; Author: Thomas Schimper <thomas@thinki>
;; Keywords:
(setq package-enable-at-startup nil
      gc-cons-threshold 10000000
      byte-compile-warnings '(not obsolete)
      warning-suppress-log-types '((comp) (bytecomp))
      native-comp-async-report-warnings-errors 'silent
      inhibit-startup-echo-area-message (user-login-name)
      frame-resize-pixelwise t)


