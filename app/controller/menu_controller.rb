include Common

class MenuController < UITableViewController

  TOP_CELL_HEIGHT = 64.5

  def viewDidLoad
    self.tableView.setTableFooterView(UIView.new)
    refresh
  end

  def refresh
    @ds = SSArrayDataSource.alloc.initWithItems(menu_items)
    @ds.tableView = self.tableView
    @ds.tableActionBlock = lambda {|at, pv, ip| false }
    @ds.cellConfigureBlock = lambda do | cell, obj, parentview, indexPath |

      if indexPath.row == 0
        # 第一行
        cell.selectionStyle = UITableViewCellSelectionStyleNone
        cell.textLabel.text = ""
      elsif indexPath.row == menu_items.size - 1 || indexPath.row == menu_items.size - 2
        # 设置和历史
        cell.textLabel.text = obj
      else
        # 源，显示名字
        cell.textLabel.text = obj.display_name
      end
    end
  end

  def tableView(tv, didSelectRowAtIndexPath: indexPath)
    sd = App.shared.delegate

    if indexPath.row == 1
      c = ListController.new
      c.source = menu_items[indexPath.row]
      open_controller c
    end

  end


  def menu_items
    items = Config.menu_items
    items.concat(["历史", "设置"])
    items = [""].concat(items)
    items
  end

end