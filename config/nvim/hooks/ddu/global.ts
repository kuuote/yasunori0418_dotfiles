import {
  ActionArguments,
  ActionFlags,
  BaseConfig,
} from "https://deno.land/x/ddu_vim@v3.4.3/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddu_vim@v3.4.3/base/config.ts";
// import { Denops, fn } from "https://deno.land/x/ddu_vim@v3.4.3/deps.ts";
import { ActionData } from "https://deno.land/x/ddu_kind_file@v0.5.3/file.ts";
import * as opt from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";

type Params = Record<string, unknown>;

const expandHome = (path: string): string => {
  return path.replace(/^~/, Deno.env.get("HOME") || "");
};

type DduUiSize = {
  winRow: number;
  winCol: number;
  winWidth: number;
  winHeight: number;
  previewFloating: boolean;
  previewSplit: "vertical" | "horizontal";
  previewRow: number;
  previewCol: number;
  previewHeight: number;
  previewWidth: number;
};

async function uiSize(
  args: ConfigArguments,
  splitRaitio: number,
  previewSplit: "horizontal" | "vertical",
): Promise<DduUiSize> {
  const denops = args.denops;
  const FRAME_SIZE = 2;
  const columns = await opt.columns.get(denops);
  const lines = await opt.lines.get(denops);
  const winRow = -1;
  const winCol = 0;

  let winHeight!: number;
  let winWidth!: number;
  let previewRow!: number;
  let previewCol!: number;
  let previewHeight!: number;
  let previewWidth!: number;

  if (previewSplit === "horizontal") {
    winHeight = Math.floor(lines / splitRaitio);
    winWidth = columns - FRAME_SIZE - 1;
    previewRow = lines - FRAME_SIZE;
    previewCol = 0;
    previewHeight = (lines - winHeight) - (FRAME_SIZE * 3);
    previewWidth = winWidth;
  } else if (previewSplit === "vertical") {
    winHeight = lines - FRAME_SIZE - 1;
    winWidth = Math.floor(columns / splitRaitio);
    previewRow = 0;
    previewCol = columns - FRAME_SIZE;
    previewHeight = winHeight;
    previewWidth = columns - winWidth - (FRAME_SIZE * 3);
  }

  return {
    winRow: winRow,
    winCol: winCol,
    winWidth: winWidth,
    winHeight: winHeight,
    previewFloating: true,
    previewSplit: previewSplit,
    previewRow: previewRow,
    previewCol: previewCol,
    previewHeight: previewHeight,
    previewWidth: previewWidth,
  };
}

export class Config extends BaseConfig {
  override async config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      uiOptions: {
        filer: {
          toggle: true,
        },
      },
      uiParams: {
        ff: {
          split: "floating",
          floatingBorder: "single",
          prompt: "",
          filterSplitDirection: "floating",
          filterFloatingPosition: "top",
          displaySourceName: "long",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewSplit: "horizontal",
          previewWindowOptions: [
            ["&signcolumn", "no"],
            ["&foldcolumn", 0],
            ["&foldenable", 0],
            ["&number", 0],
            ["&relativenumber", 0],
            ["&wrap", 0],
          ],
        },
        filer: {
          ...{
            split: "floating",
            splitDirection: "topleft",
            floatingBorder: "single",
            sort: "filename",
            sortTreesFirst: true,
            displayRoot: false,
            previewFloatingBorder: "single",
            previewWindowOptions: [
              ["&signcolumn", "no"],
              ["&foldcolumn", 0],
              ["&foldenable", 0],
              ["&number", 0],
              ["&relativenumber", 0],
              ["&wrap", 0],
            ],
          },
          ...await uiSize(args, 5, "vertical"),
        },
      },
      sourceOptions: {
        _: {
          matchers: ["matcher_substring"],
        },
        file: {
          columns: ["icon_filename"],
        },
        file_rec: {
          ignoreCase: true,
          converters: [
            "converter_devicon",
            "converter_hl_dir",
          ],
        },
        dein: {
          defaultAction: "cd",
        },
        help: {
          defaultAction: "open",
        },
        dein_update: {
          matchers: ["matcher_dein_update"],
        },
        path_history: {
          defaultAction: "uiCd",
        },
        git_status: {
          converters: [
            "converter_hl_dir",
            "converter_devicon",
            "converter_git_status",
          ],
        },
        mr: {
          converters: [
            "converter_devicon",
            "converter_hl_dir",
          ],
        },
        buffer: {
          converters: [
            "converter_hl_dir",
          ],
        },
        rg: {
          converters: [
            "converter_devicon",
            "converter_hl_dir",
          ],
        },
      },
      sourceParams: {
        dein_update: {
          useGraphQL: false,
        },
        rg: {
          args: [
            "--json",
            "--ignore-case",
            "--column",
            "--no-heading",
            "--color",
            "never",
          ],
          highlights: {
            word: "Title",
          },
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
          actions: {
            uiCd: async (
              args: ActionArguments<Params>,
            ): Promise<ActionFlags> => {
              const action = args.items[0].action as ActionData;

              await args.denops.call("ddu#ui#do_action", "itemAction", {
                name: "narrow",
                params: {
                  path: action.path,
                },
              });

              return Promise.resolve(ActionFlags.None);
            },
            cdOpen: async (
              args: ActionArguments<Params>,
            ): Promise<ActionFlags> => {
              const action = args.items[0].action as ActionData;
              await args.denops.call("chdir", action.path);
              await args.denops.cmd("edit .");

              return Promise.resolve(ActionFlags.None);
            },
          },
        },
        action: {
          defaultAction: "do",
        },
        word: {
          defaultAction: "append",
        },
        deol: {
          defaultAction: "switch",
        },
        readme_viewer: {
          defaultAction: "open",
        },
        dein_update: {
          defaultAction: "viewDiff",
        },
        git_status: {
          defaultAction: "open",
        },
      },
      actionOptions: {
        narrow: { quit: false },
        echo: { quit: false },
        echoDiff: { quit: false },
      },
      filterParams: {
        matcher_substring: {
          highlightMatched: "Search",
        },
        matcher_kensaku: {
          highlightMatched: "Search",
        },
        matcher_fuse: {
          threshold: 0.6,
        },
        merge: {
          filters: [
            {
              name: "matcher_kensaku",
              weight: 2.0,
            },
            {
              name: "matcher_fuse",
            },
          ],
          unique: true,
        },
        converter_hl_dir: {
          hlGroup: [
            "Directory",
            "Number",
            "Type",
          ],
        },
      },
      columnParams: {
        icon_filename: {
          span: 2,
          iconWidth: 2,
          defaultIcon: {
            icon: "",
          },
        },
      },
    });

    // UI: fuzzy-finder

    args.contextBuilder.patchLocal("current-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        { name: "file_rec" },
      ],
    });

    args.contextBuilder.patchLocal("dotfiles-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        {
          name: "file_rec",
          options: {
            path: expandHome("~/dotfiles"),
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("project-list-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        {
          name: "file",
          options: {
            path: Deno.env.get("WORKING_DIR"),
            defaultAction: "cdOpen",
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("help-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sync: true,
      sources: [
        { name: "help" },
        { name: "readme_viewer" },
      ],
    });

    args.contextBuilder.patchLocal("search_line-ff", {
      ui: "ff",
      uiParams: {
        ff: { startFilter: true },
      },
      sources: [
        {
          name: "line",
          options: {
            matchers: ["matcher_fuse"],
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("buffer-ff", {
      ui: "ff",
      sources: [
        { name: "buffer" },
      ],
    });

    args.contextBuilder.patchLocal("plugin-list-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        {
          name: "dein",
          options: {
            defaultAction: "cdOpen",
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("home-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        {
          name: "file",
          options: {
            path: Deno.env.get("HOME"),
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("register-ff", {
      ui: "ff",
      sources: [
        {
          name: "register",
        },
      ],
    });

    args.contextBuilder.patchLocal("mrr-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        {
          name: "mr",
          options: {
            defaultAction: "cdOpen",
          },
          params: {
            kind: "mrr",
            current: false,
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("mru-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: false,
        },
      },
      sources: [
        {
          name: "mr",
          params: {
            kind: "mru",
            current: true,
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("highlight-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
        },
      },
      sources: [
        { name: "highlight" },
      ],
    });

    args.contextBuilder.patchLocal("dein_update-ff", {
      ui: "ff",
      sources: [
        {
          name: "dein_update",
        },
      ],
    });

    args.contextBuilder.patchLocal("ripgrep-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          ...{
            startAutoAction: true,
            autoAction: {
              delay: 0,
              name: "preview",
            },
            autoResize: false,
            startFilter: true,
            filterFloatingPosition: "top",
          },
          ...await uiSize(args, 3, "horizontal"),
        }
      },
      sources: [
        {
          name: "rg",
          options: {
            matchers: [],
            volatile: true,
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("path_history-ff", {
      ui: "ff",
      sources: [
        { name: "path_history" },
      ],
    });

    args.contextBuilder.patchLocal("git_status-ff", {
      ui: "ff",
      uiParams: {
        ff: {
          ...{
            startAutoAction: true,
            autoAction: {
              delay: 0,
              name: "preview",
            },
            autoResize: false,
            filterFloatingPosition: "bottom",
          },
          ...await uiSize(args, 2, "vertical"),
        },
      },
      sources: [
        {
          name: "git_status",
        },
      ],
    });

    args.contextBuilder.patchLocal("git_diff-ff", {
      ui: "ff",
      sources: [
        {
          name: "git_diff",
        },
      ],
    });

    // UI: filer

    args.contextBuilder.patchLocal("current-filer", {
      ui: "filer",
      sources: [
        { name: "file" },
      ],
    });

    args.contextBuilder.patchLocal("home-filer", {
      ui: "filer",
      sources: [
        {
          name: "file",
          options: {
            path: Deno.env.get("HOME"),
          },
        },
      ],
    });

    args.contextBuilder.patchLocal("dotfiles-filer", {
      ui: "filer",
      sources: [
        {
          name: "file",
          options: {
            path: expandHome("~/dotfiles"),
          },
        },
      ],
    });

    return Promise.resolve();
  }
}
