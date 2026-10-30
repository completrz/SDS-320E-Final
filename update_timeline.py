#!/usr/bin/env python3
"""Create a GitHub-friendly SVG showing elapsed calendar time for the CS2 project."""

from __future__ import annotations

import argparse
from datetime import date, datetime
from html import escape
from pathlib import Path
from zoneinfo import ZoneInfo

START = date(2026, 9, 18)
DESCRIPTIVE = date(2026, 11, 6)
END = date(2026, 12, 4)
OUT = Path(__file__).resolve().parents[1] / "assets" / "project-progress.svg"


def make_svg(today: date) -> str:
    total_days = (END - START).days
    elapsed = max(0, min(total_days, (today - START).days))
    progress = elapsed / total_days
    percent = progress * 100
    days_left = max(0, (END - today).days)
    right_label = (
        f"{days_left} days remaining" if days_left > 0
        else "Deadline reached"
    )
    left_label = "of timeline elapsed"

    x = 32
    width = 656
    bar_y = 103
    bar_h = 14
    filled = width * progress
    descriptive_x = x + width * (DESCRIPTIVE - START).days / total_days
    # Escaping is defensive; all strings are hardcoded/generated.
    title = escape("CS2 project schedule")
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="720" height="178" viewBox="0 0 720 178" role="img" aria-labelledby="timeline-title timeline-desc">
  <title id="timeline-title">{title}</title>
  <desc id="timeline-desc">{percent:.0f}% of project calendar time elapsed between September 18 and December 4, 2026. {escape(right_label)}.</desc>
  <defs>
    <clipPath id="bar-clip"><rect x="{x}" y="{bar_y}" width="{width}" height="{bar_h}" rx="7"/></clipPath>
    <linearGradient id="bar-fill"><stop offset="0%" stop-color="#388bfd"/><stop offset="100%" stop-color="#58a6ff"/></linearGradient>
  </defs>
  <rect x="0.75" y="0.75" width="718.5" height="176.5" rx="12" fill="#0d1117" stroke="#30363d" stroke-width="1.5"/>
  <g font-family="-apple-system,BlinkMacSystemFont,'Segoe UI',Arial,sans-serif">
    <text x="32" y="32" font-size="12" font-weight="700" letter-spacing="1.3" fill="#8b949e">PROJECT SCHEDULE</text>
    <text x="688" y="32" text-anchor="end" font-size="12" fill="#8b949e">SEP 18 — DEC 4, 2026</text>

    <text x="32" y="82" font-size="33" font-weight="700" fill="#f0f6fc">{percent:.0f}%</text>
    <text x="130" y="80" font-size="14" fill="#8b949e">{escape(left_label)}</text>
    <text x="688" y="81" text-anchor="end" font-size="14" font-weight="600" fill="#c9d1d9">{escape(right_label)}</text>

    <rect x="{x}" y="{bar_y}" width="{width}" height="{bar_h}" rx="7" fill="#21262d"/>
    <g clip-path="url(#bar-clip)">
      <rect x="{x}" y="{bar_y}" width="{filled:.2f}" height="{bar_h}" fill="url(#bar-fill)"/>
    </g>
    <circle cx="{descriptive_x:.2f}" cy="{bar_y+bar_h/2}" r="4.5" fill="#0d1117" stroke="#8b949e" stroke-width="2"/>

    <text x="32" y="145" font-size="12" font-weight="600" fill="#c9d1d9">Proposal</text>
    <text x="32" y="162" font-size="11" fill="#8b949e">Sep 18</text>
    <text x="{descriptive_x:.2f}" y="145" text-anchor="middle" font-size="12" font-weight="600" fill="#c9d1d9">Descriptive analysis</text>
    <text x="{descriptive_x:.2f}" y="162" text-anchor="middle" font-size="11" fill="#8b949e">Nov 6</text>
    <text x="688" y="145" text-anchor="end" font-size="12" font-weight="600" fill="#c9d1d9">Final project</text>
    <text x="688" y="162" text-anchor="end" font-size="11" fill="#8b949e">Dec 4</text>
  </g>
</svg>
'''


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--date", help="Override today's date for preview, YYYY-MM-DD")
    args = parser.parse_args()
    today = date.fromisoformat(args.date) if args.date else datetime.now(ZoneInfo("America/Chicago")).date()
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(make_svg(today), encoding="utf-8")
    print(f"Updated {OUT} for {today.isoformat()}")


if __name__ == "__main__":
    main()
