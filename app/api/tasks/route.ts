import { type NextRequest, NextResponse } from "next/server"

// Mock database - in production, use MongoDB
const tasks = [
  {
    id: "1",
    title: "Update homepage design",
    description: "Redesign the homepage with new branding guidelines",
    status: "In Progress",
    priority: "High",
    projectId: "1",
    assignedTo: "user1",
    dueDate: "2024-02-10",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: "2",
    title: "Implement user authentication",
    description: "Add login and registration functionality",
    status: "Todo",
    priority: "Medium",
    projectId: "2",
    assignedTo: "user2",
    dueDate: "2024-02-20",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: "3",
    title: "Create social media content",
    description: "Develop content calendar for Q1",
    status: "Completed",
    priority: "Low",
    projectId: "1",
    assignedTo: "user3",
    dueDate: "2024-01-25",
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
]

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const projectId = searchParams.get("projectId")
    const status = searchParams.get("status")
    const assignedTo = searchParams.get("assignedTo")

    let filteredTasks = tasks

    if (projectId) {
      filteredTasks = filteredTasks.filter((t) => t.projectId === projectId)
    }

    if (status) {
      filteredTasks = filteredTasks.filter((t) => t.status === status)
    }

    if (assignedTo) {
      filteredTasks = filteredTasks.filter((t) => t.assignedTo === assignedTo)
    }

    return NextResponse.json({
      tasks: filteredTasks,
      total: filteredTasks.length,
    })
  } catch (error) {
    console.error("Get tasks error:", error)
    return NextResponse.json({ message: "Internal server error" }, { status: 500 })
  }
}

export async function POST(request: NextRequest) {
  try {
    const { title, description, priority, projectId, assignedTo, dueDate } = await request.json()

    // Validation
    if (!title || !projectId) {
      return NextResponse.json({ message: "Title and project ID are required" }, { status: 400 })
    }

    // Create task
    const task = {
      id: Date.now().toString(),
      title,
      description: description || "",
      status: "Todo",
      priority: priority || "Medium",
      projectId,
      assignedTo: assignedTo || null,
      dueDate: dueDate || null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    }

    tasks.push(task)

    return NextResponse.json(
      {
        message: "Task created successfully",
        task,
      },
      { status: 201 },
    )
  } catch (error) {
    console.error("Create task error:", error)
    return NextResponse.json({ message: "Internal server error" }, { status: 500 })
  }
}
